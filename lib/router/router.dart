import 'package:app_demo_flutter/presentation/screen/start_screen/start_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_route/annotations.dart';

class RoutePaths{
  static const start = '/Start';
}

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(path: RoutePaths.start, page: StartScreen, initial: true),
])
class $AppRouter {}