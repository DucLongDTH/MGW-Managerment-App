import 'package:app_demo_flutter/presentation/screen/home_screen/home_screen.dart';
import 'package:app_demo_flutter/presentation/screen/login_screen/login_screen.dart';
import 'package:app_demo_flutter/presentation/screen/start_screen/splash_screen.dart';
import 'package:app_demo_flutter/presentation/screen/start_screen/start_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_route/annotations.dart';

class RoutePaths{
  static const splash ='/Splash';
  static const start = '/Start';
  static const login = '/loginScreen';
  static const home = '/homeScreen';
}

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(path: RoutePaths.start, page: StartScreen),
  AutoRoute(path: RoutePaths.splash, page: SplashScreen, initial: true),
  AutoRoute(path: RoutePaths.home, page: HomeScreen),
  AutoRoute(path: RoutePaths.login, page: LoginScreen),
])
class $AppRouter {}