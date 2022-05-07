import 'package:app_demo_flutter/config/app_config/app_config.dart';
import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:app_demo_flutter/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _nextToMainOrLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 130.h,
                width: double.infinity,
              ),
              Image.asset(
                Assets.images.logo.path,
                width: 90.w,
                height: 90.h,
              ),
              SizedBox(
                height: 130.h,
                width: double.infinity,
              ),
              Text(
                companyName,
                style: ThemeProvider.instance.textStyleBold24
                    .copyWith(color: darkBlue),
              ),
            ]),
      ),
    );
  }

  void _nextToMainOrLogin() async {
    await Future.delayed(Duration(seconds: 2), () {
      // TODO check login or main screen
      AutoRouter.of(context).replaceNamed(RoutePaths.login);
    });
  }
}
