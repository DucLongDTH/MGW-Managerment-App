import 'package:app_demo_flutter/config/app_config/app_config.dart';
import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/l10n/gen/app_localizations.dart';
import 'package:app_demo_flutter/l10n/l10n.dart';
import 'package:app_demo_flutter/presentation/cubit/demo_cubit/demo_cubit.dart';
import 'package:app_demo_flutter/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_demo_flutter/di/app_di.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _localizationsDelegates = [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ];
    ThemeProvider.instance.initAppTheme();
    return MultiBlocProvider(
      providers: _appProviders,
      child: ScreenUtilInit(
        builder: (){
          final _appRouter = di.sl.get<AppRouter>();
          final _themeData = ThemeProvider.instance.themeData;
          return Builder(builder: (context) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: appName,
              theme: _themeData,
              supportedLocales: L10n.all,
              localizationsDelegates: _localizationsDelegates,
              routerDelegate: AutoRouterDelegate(_appRouter),
              routeInformationParser: _appRouter.defaultRouteParser(),
            );
          });
        },
        designSize: const Size(375, 812),
      ),
    );
  }

  List<BlocProviderSingleChildWidget> get _appProviders {
    return [
      BlocProvider(
        create: (_) => di.sl<DemoCubit>(),
      ),
    ];
  }

  List<BlocListener> get _blocListeners {
    return [
    ];
  }
}
