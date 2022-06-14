import 'package:app_demo_flutter/config/app_config/app_config.dart';
import 'package:app_demo_flutter/config/core/shared_preferences.dart';
import 'package:app_demo_flutter/config/core/shared_preferences_impl.dart';
import 'package:app_demo_flutter/router/router.gr.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:app_demo_flutter/config/dio_config/setup_dio.dart' as dio;
import 'package:app_demo_flutter/di/auth_di.dart' as demo;
import 'package:app_demo_flutter/di/product_di.dart' as product;

final sl = GetIt.instance;

Future<void> initDI() async {
  sl.registerSingleton(AppRouter());
  sl.registerSingleton<Dio>(dio.createCoreDio(baseUrl));
  sl.registerSingleton(baseUrl, instanceName: baseUrlName);
  sl.registerSingleton<AppSharedPreferences>(AppSharedPreferencesImpl());
  demo.registerDI();
  product.registerDI();
}
