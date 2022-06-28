import 'dart:developer';

import 'package:app_demo_flutter/config/app_config/app_config.dart';
import 'package:app_demo_flutter/config/core/shared_preferences.dart';
import 'package:app_demo_flutter/config/core/shared_preferences_impl.dart';
import 'package:app_demo_flutter/config/dio_config/setup_dio.dart';
import 'package:app_demo_flutter/constant/key_utils.dart';
import 'package:app_demo_flutter/data/model/token_response/token_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthTokenService {
  final _options = Options(
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
  );

  Future<bool> refreshToken(
      {AppSharedPreferences? appSharedPreferences, Dio? dioClient}) async {
    final _appPre = appSharedPreferences ?? AppSharedPreferencesImpl();
    final dio = dioClient ?? Dio();
    dio.options.baseUrl = baseUrl;
    final resultToken =
        await getRefreshToken(dio, await _appPre.getString(authTokenKey) ?? '');
    return true;
  }

  Future<TokenResponse> getRefreshToken(
      Dio dioClient, String accessToken) async {
    final options = Options(headers: {
      ...?_options.headers,
      'Authorization': 'Bearer $accessToken',
    });
    if (kDebugMode) {
      dioClient.interceptors.add(LogInterceptor(logPrint: (Object logM) {
        log(logM.toString());
      }));
      dioClient.interceptors.add(Dio2CurlInterceptor());
    }
    final deviceID = await getDeviceID();
    final data = _buildData(deviceID);
    //TODO: HANDLE LATER
    final response = await dioClient.post('/api/v2/auth/refresh',
        options: options, data: data);
    debugPrint('');

    return TokenResponse.fromJson(response.data);
  }

  Map<String, String?> _buildData(String? deviceID) =>
      {'platform': 'mobile', 'device': deviceID};
}
