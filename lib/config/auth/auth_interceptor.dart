// ignore_for_file: deprecated_member_use
import 'dart:developer';

import 'package:app_demo_flutter/config/core/shared_preferences.dart';
import 'package:app_demo_flutter/config/dio_config/dio_error_intercaptors.dart';
import 'package:app_demo_flutter/constant/key_utils.dart';
import 'package:dio/dio.dart';

Map<String, dynamic> setupAuthHeaders(String? token) {
  Map<String, dynamic> headers = {};
  if (token != null) {
    headers['Authorization'] = 'Bearer $token';
  }
  return headers;
}

class AuthInterceptor extends QueuedInterceptorsWrapper {
  final AppSharedPreferences auth;
  final Dio dio;
  final Future Function()? refreshToken;

  AuthInterceptor(this.auth, this.dio, this.refreshToken);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      options.headers.addAll(await _setupTokenHeaders());
      super.onRequest(options, handler);
    } catch (e) {
      if (e is DioError) {
        handler.reject(e);
      } else {
        handler.reject(DioError(
            requestOptions: options, type: DioErrorType.other, error: e));
      }
    }
  }

  Future<Map<String, dynamic>> _setupTokenHeaders() async {
    final authToken = await auth.getString(authTokenKey);
    return setupAuthHeaders(authToken);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (refreshToken != null && _isUnAuthorized(err)) {
      //catch the 401 here https://github.com/flutterchina/dio/blob/develop/example/lib/queued_interceptor_crsftoken.dart
      _lockDio();
      final requestOptions = err.requestOptions;
      try {
        log('Refreshing token ' + requestOptions.path);
        await refreshToken?.call();
        log('Refreshing token success ' + requestOptions.path);
      } catch (e) {
        log('Refreshing token fail ' + requestOptions.path);
        _unlockDio();
        handler.next(_get401DioError(requestOptions, e));
        return;
      }
      requestOptions.headers.addAll(await _setupTokenHeaders());
      _unlockDio();
      try {
        requestOptions.headers['Authorization'] =
            'Bearer ${await auth.getString(authTokenKey)}';
        //retry request
        log('Retrying request ' + requestOptions.path);
        final response = await Dio(dio.options).fetch(requestOptions);
        log('Retrying request success ' + requestOptions.path);
        handler.resolve(response);
      } catch (e) {
        log('Retrying request fail ' + requestOptions.path);
        handler.next(_get401DioError(requestOptions, e));
      }
    } else {
      super.onError(err, handler);
    }
  }

  DioError _get401DioError(RequestOptions requestOptions, Object e) {
    return UnauthorizedException(DioError(
        requestOptions: requestOptions,
        type: DioErrorType.response,
        response: Response(
          statusCode: 401,
          data: {'error': 'Unauthorized'},
          requestOptions: requestOptions,
        ),
        error: e));
  }

  bool _isUnAuthorized(DioError err) {
    try {
      return (err.response?.statusCode == 401 ||
          err.error?.source
                  ?.toString()
                  .toLowerCase()
                  .contains('unauthorized') ==
              true);
    } catch (e) {
      return false;
    }
  }

  void _unlockDio() {
    dio.unlock();
    dio.interceptors.responseLock.unlock();
    dio.interceptors.errorLock.unlock();
  }

  void _lockDio() {
    dio.lock();
    dio.interceptors.responseLock.lock();
    dio.interceptors.errorLock.lock();
  }
}
