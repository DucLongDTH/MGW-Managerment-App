import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/constant/dialog_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:app_demo_flutter/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:app_demo_flutter/presentation/cubit/login_cubit/login_state.dart';
import 'package:app_demo_flutter/router/router.dart';
import 'package:app_demo_flutter/widget/mgw_base_button.dart';
import 'package:app_demo_flutter/widget/mgw_loading.dart';
import 'package:app_demo_flutter/widget/mgw_textfield.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  var _isHidePassword = true;
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: ValueListenableBuilder<bool>(
            valueListenable: _isLoading,
            builder: (context, value, child) {
              return Center(
                child: MgwOSLoading(
                  mainWidget: child!,
                  isShowLoading: value,
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50.h),
                  Image.asset(Assets.images.logo.path,
                      width: 60.w, height: 60.h),
                  SizedBox(height: 50.h),
                  _buildCardLogin()
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildCardLogin() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        boxShadow: const [
          BoxShadow(
            color: greyShadow,
            spreadRadius: 4,
            blurRadius: 6,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign in \nto continue!',
                style: ThemeProvider.instance.textStyleBold26
                    .copyWith(color: black, height: 1.2)),
            SizedBox(height: 20.h),
            _buildTextFieldUserName(),
            SizedBox(
              height: 15.h,
            ),
            _buildTextFieldPassword(),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {},
              child: Align(
                alignment: Alignment.topRight,
                child: Text('Forgot Password?',
                    style: ThemeProvider.instance.textStyleBold14
                        .copyWith(color: cyan)),
              ),
            ),
            SizedBox(height: 25.h),
            _buildButtonLogin()
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldUserName() {
    return MgwOSTextField(
      inputFieldKey: const Key('txtUserName'),
      title: 'UserName',
      keyboardType: TextInputType.emailAddress,
      controller: _usernameController,
      widgetLeft: SvgPicture.asset(
        Assets.icons.icUser,
        width: 21.w,
        height: 21.h,
        color: greyIcon,
      ),
      onChange: (value) {},
      onSaved: (value) {},
    );
  }

  Widget _buildTextFieldPassword() {
    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return MgwOSTextField(
        inputFieldKey: const Key('txtPassword'),
        title: 'Password',
        keyboardType: TextInputType.text,
        controller: _passwordController,
        obscureText: _isHidePassword,
        widgetLeft: SvgPicture.asset(
          Assets.icons.icPassword,
          width: 21.w,
          height: 21.h,
          color: greyIcon,
        ),
        widgetRight: GestureDetector(
          onTap: () {
            setState(() {
              _isHidePassword = !_isHidePassword;
            });
            debugPrint('onTap show password');
          },
          child: SvgPicture.asset(
            _isHidePassword ? Assets.icons.icVisible : Assets.icons.icHidden,
            width: 21.w,
            height: 21.h,
            color: greyIcon,
          ),
        ),
        onChange: (value) {
          debugPrint('onChange $value');
        },
        onSaved: (value) {},
      );
    });
  }

  Widget _buildButtonLogin() {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        _isLoading.value = false;
        state.maybeWhen(
            orElse: () {},
            loading: () {
              _isLoading.value = true;
            },
            error: (err) {
              // showMgwOSDialog(context, null, (dialogContext) {
              //   return const MgwOSPopup(title: 'ERROR', buttons: []);
              // });
              showDialogDefaultAction(context, err);
            },
            success: () {
              AutoRouter.of(context).replaceNamed(RoutePaths.home);
            });
      },
      child: MgwOSBaseButton(
        width: double.infinity,
        colorBackground: darkBlue,
        onPressed: () {
          // TODO CALL API LOGIN
          BlocProvider.of<LoginCubit>(context).login(
              _usernameController.text.trim(), _passwordController.text.trim());
          // AutoRouter.of(context).replaceNamed(RoutePaths.home);
        },
        cornerRadius: 12.r,
        text: 'Log in',
        titleStyle:
            ThemeProvider.instance.textStyleBold18.copyWith(color: neonBlue),
      ),
    );
  }
}
