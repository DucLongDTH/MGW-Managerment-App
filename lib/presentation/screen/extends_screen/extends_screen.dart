import 'package:app_demo_flutter/constant/avatar_utils.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:app_demo_flutter/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:app_demo_flutter/presentation/cubit/logout_cubit/logout_cubit.dart';
import 'package:app_demo_flutter/router/router.dart';
import 'package:app_demo_flutter/widget/base/base_state.dart';
import 'package:app_demo_flutter/widget/mgw_appbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styled_widget/styled_widget.dart';

class ExtendsScreen extends StatefulWidget {
  const ExtendsScreen({Key? key}) : super(key: key);

  @override
  State<ExtendsScreen> createState() => _ExtendsScreenState();
}

class _ExtendsScreenState extends BaseState<ExtendsScreen> {
  late LogoutCubit _logoutCubit;

  @override
  void initState() {
    super.initState();
    _logoutCubit = BlocProvider.of<LogoutCubit>(context);
  }

  @override
  Widget buildLayout(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: white,
        appBar: MgwOSAppBar(
            height: 80.h,
            widgetLeft: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: getAvatarByName('Nguyen Duc Long'),
            ),
            widgetRight: GestureDetector(
                onTap: (() async {
                  loadingOverlay.show(context);
                  await _logoutCubit.logout().then((value) {
                    AutoRouter.of(context).replaceNamed(RoutePaths.login);
                  });
                  loadingOverlay.hide();
                }),
                child: SvgPicture.asset(
                  Assets.icons.icSignOut,
                  color: white,
                )).padding(right: 8.w),
            title: 'Nguyen Duc Long',
            subTitle: 'Admin',
            textColor: white,
            backgroundColor: darkBlue,
            elevation: 0),
        body: Container());
  }
}
