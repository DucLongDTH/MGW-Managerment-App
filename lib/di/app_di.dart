import 'package:app_demo_flutter/config/app_config/app_config.dart';
import 'package:app_demo_flutter/config/auth/auth_service.dart';
import 'package:app_demo_flutter/config/core/shared_preferences.dart';
import 'package:app_demo_flutter/config/core/shared_preferences_impl.dart';
import 'package:app_demo_flutter/config/dialog_manager/app_dialog_manager.dart';
import 'package:app_demo_flutter/config/dialog_manager/dialog_manager.dart';
import 'package:app_demo_flutter/firebase_options.dart';
import 'package:app_demo_flutter/router/router.gr.dart';
import 'package:app_demo_flutter/widget/base/loading_overlay.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:app_demo_flutter/config/dio_config/setup_dio.dart' as dio;
import 'package:app_demo_flutter/di/auth_di.dart' as demo;
import 'package:app_demo_flutter/di/product_di.dart' as product;

final sl = GetIt.instance;

Future<void> initDI() async {
  await initFirebase();
  sl.registerLazySingleton(() => AppRouter());
  sl.registerLazySingleton(() => baseUrl, instanceName: baseUrlName);
  sl.registerLazySingleton<AppSharedPreferences>(
      () => AppSharedPreferencesImpl());
  final authTokenService = AuthTokenService();
  sl.registerLazySingleton<Dio>(() =>
      dio.createCoreDio(sl.get(), baseUrl, authTokenService.refreshToken));
  sl.registerLazySingleton<DialogManager>(() => AppDialogManager());
  sl.registerLazySingleton(() => LoadingOverlay());
  demo.registerDI();
  product.registerDI();
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
