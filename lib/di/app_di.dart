import 'package:app_demo_flutter/router/router.gr.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:app_demo_flutter/config/dio_config/setup_dio.dart' as dio;

final sl = GetIt.instance;

Future<void> initDI() async {
  sl.registerSingleton(AppRouter());
  sl.registerSingleton<Dio>(dio.createCoreDio(''));
}