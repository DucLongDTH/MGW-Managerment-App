import 'package:app_demo_flutter/config/app_config/app_config.dart';
import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/l10n/gen/app_localizations.dart';
import 'package:app_demo_flutter/l10n/l10n.dart';
import 'package:app_demo_flutter/presentation/cubit/demo_cubit/demo_cubit.dart';
import 'package:app_demo_flutter/presentation/cubit/product_cubit/get_product_cubit.dart';
import 'package:app_demo_flutter/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_demo_flutter/di/app_di.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarColor: Colors.transparent,
        systemStatusBarContrastEnforced: true,
        systemNavigationBarContrastEnforced: true // status bar color
        ));
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
        builder: () {
          final _appRouter = di.sl.get<AppRouter>();
          final _themeData = ThemeProvider.instance.themeData;
          return Builder(builder: (context) {
            return MaterialApp.router(
              builder: (context, child) {
                ScreenUtil.setContext(context);
                return MediaQuery(
                  //Setting font does not change with system font size
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child ?? const SizedBox(),
                );
              },
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
      BlocProvider(
        create: (_) => di.sl<GetProductCubit>(),
      ),
    ];
  }

  List<BlocListener> get _blocListeners {
    return [];
  }
}
