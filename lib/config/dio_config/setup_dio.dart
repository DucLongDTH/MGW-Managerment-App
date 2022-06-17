import 'dart:developer';

import 'package:app_demo_flutter/config/auth/auth_interceptor.dart';
import 'package:app_demo_flutter/config/core/shared_preferences.dart';
import 'package:app_demo_flutter/config/dio_config/dio_error_intercaptors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

Dio createCoreDio(AppSharedPreferences auth, String _baseUrl,
    Future Function()? refreshToken) {
  final dio = Dio();
  dio.options.baseUrl = _baseUrl;
  dio.options.connectTimeout = 60000; //30s
  dio.options.receiveTimeout = 60000;
  dio.options.receiveDataWhenStatusError = true;
  dio.options.contentType = 'application/json';
  dio.options.headers.putIfAbsent('lang', () => 'vi');
  dio.options.headers.putIfAbsent('Accept', () => 'application/json');
  dio.interceptors.add(DioErrorInterceptors());
  dio.interceptors.add(AuthInterceptor(auth, dio, refreshToken));
  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(logPrint: (Object logM) {
      log(logM.toString());
    }));
    dio.interceptors.add(Dio2CurlInterceptor());
  }

  return dio;
}

class Dio2CurlInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      log('COPY CURL and send it to BE');
      log(cURLRepresentation(options));
    } catch (e) {
      log('Create CURL failure!! - ' + e.toString());
    }
    super.onRequest(options, handler);
  }
}

// A simple utility function to dump `curl` from "Dio" requests
String dio2Curl(RequestOptions requestOption) {
  var curl = '';

  // Add PATH + REQUEST_METHOD
  final String url = requestOption.path.startsWith('https://')
      ? requestOption.path
      : '${requestOption.baseUrl}${requestOption.path}';
  curl += 'curl --request ${requestOption.method} \'$url\'';

  // Include headers
  for (var key in requestOption.headers.keys) {
    curl += ' -H \'$key: ${requestOption.headers[key]}\'';
  }

  // Include data if there is data
  if (requestOption.data != null) {
    curl += ' --data-binary \'${requestOption.data}\'';
  }

  curl += ' --insecure'; //bypass https verification

  return curl;
}

String cURLRepresentation(RequestOptions options) {
  List<String> components = ['curl -i'];
  //if (options.method.toUpperCase() == 'GET') {
  components.add('-X ${options.method}');
  //}

  options.headers.forEach((k, v) {
    if (k != 'Cookie') {
      components.add('-H \'$k: $v\'');
    }
  });

  if (options.method.toUpperCase() != 'GET') {
    var data = json.encode(options.data);
    data = data.replaceAll('\'', '\\\'');
    components.add('-d \'$data\'');
  }

  components.add('\'${options.uri.toString()}\'');

  return components.join('\\\n\t');
}

extension Curl on RequestOptions {
  String toCurlCmd() {
    String cmd = 'curl';

    String header = headers
        .map((key, value) {
          if (key == 'content-type' &&
              value.toString().contains('multipart/form-data')) {
            value = 'multipart/form-data;';
          }
          return MapEntry(key, "-H '$key: $value'");
        })
        .values
        .join(' ');
    String url = '$baseUrl$path';
    if (queryParameters.isNotEmpty) {
      String query = queryParameters
          .map((key, value) {
            return MapEntry(key, '$key=$value');
          })
          .values
          .join('&');

      url += (url.contains('?')) ? query : '?$query';
    }
    if (method == 'GET') {
      cmd += " $header '$url'";
    } else {
      Map<String, dynamic> files = {};
      String postData = "-d ''";
      if (data != null) {
        if (data is FormData) {
          FormData fdata = data as FormData;
          for (var element in fdata.files) {
            MultipartFile file = element.value;
            files[element.key] = '@${file.filename}';
          }
          for (var element in fdata.fields) {
            files[element.key] = element.value;
          }
          if (files.isNotEmpty) {
            postData = files
                .map((key, value) => MapEntry(key, "-F '$key=$value'"))
                .values
                .join(' ');
          }
        } else if (data is Map<String, dynamic>) {
          files.addAll(data);

          if (files.isNotEmpty) {
            postData = "-d '${json.encode(files).toString()}'";
          }
        }
      }

      String method = this.method.toString();
      cmd += " -X $method $postData $header '$url'";
    }

    return cmd;
  }
}
