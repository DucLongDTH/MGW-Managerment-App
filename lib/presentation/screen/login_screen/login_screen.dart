import 'package:app_demo_flutter/config/dio_config/dio_error_intercaptors.dart';
import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/constant/dialog_utils.dart';
import 'package:app_demo_flutter/constant/validator_utils.dart';
import 'package:app_demo_flutter/constant/widget_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:app_demo_flutter/l10n/gen/app_localizations.dart';
import 'package:app_demo_flutter/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:app_demo_flutter/presentation/cubit/login_cubit/login_state.dart';
import 'package:app_demo_flutter/router/router.dart';
import 'package:app_demo_flutter/widget/base/base_state.dart';
import 'package:app_demo_flutter/widget/mgw_app_button.dart';
import 'package:app_demo_flutter/widget/mgw_base_button.dart';
import 'package:app_demo_flutter/widget/mgw_popup.dart';
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

class _LoginScreenState extends BaseState<LoginScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  String errorUsernameMess = '';
  String errorPasswordMess = '';
  var _isHidePassword = true;

  @override
  void initState() {
    _usernameController =
        TextEditingController(text: 'longvkook0312@gmail.com');
    _passwordController = TextEditingController(text: 'Asd@12345');
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget buildLayout(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: white,
        body: WillPopScope(
          onWillPop: (() => Future.value(false)),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.h),
                    Image.asset(Assets.images.logo.path,
                        width: 100.w, height: 100.h),
                    SizedBox(height: 25.h),
                    _buildCardLogin()
                  ],
                ),
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
            color: Colors.black26,
            spreadRadius: 0,
            blurRadius: 20,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Align(
            //     alignment: Alignment.topCenter,
            //     child: Image.asset(Assets.images.logo.path,
            //         width: 60.w, height: 60.h)),
            SizedBox(height: 20.h),
            _buildTextFieldUserName(),
            SizedBox(
              height: 15.h,
            ),
            _buildTextFieldPassword(),
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  AutoRouter.of(context).pushNamed(RoutePaths.register);
                },
                child:
                    // Align(
                    //   alignment: Alignment.topRight,
                    //   child:
                    Text(AppLocalizations.of(context)!.lbl_register,
                        style: ThemeProvider.instance.textStyleBold14
                            .copyWith(color: cyan)),
              ),
              // ),
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
      errorWidget: buildErrorForm(errorUsernameMess),
      inputFieldKey: const Key('txtUserName'),
      title: AppLocalizations.of(context)!.lbl_email,
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
        errorWidget: buildErrorForm(errorPasswordMess),
        inputFieldKey: const Key('txtPassword'),
        title: AppLocalizations.of(context)!.lbl_password,
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
        loadingOverlay.hide();
        state.maybeWhen(
            orElse: () {},
            loading: () {
              loadingOverlay.show(context);
            },
            error: (err) {
              if (err is UnauthorizedException || err is BadRequestException) {
                showMgwOSDialog(context, const Key(''), (dialogContext) {
                  return MgwOSPopup(
                      title: AppLocalizations.of(context)!.lbl_error_title,
                      subTitle:
                          AppLocalizations.of(context)!.lbl_error_wrong_account,
                      buttons: [
                        MgwOSAppButton(
                            style: AppButtonStyle.fill,
                            title:
                                AppLocalizations.of(context)!.lbl_agree_button,
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                            })
                      ]);
                });
              } else {
                showDialogDefaultAction(context, err);
              }
            },
            success: () {
              AutoRouter.of(context).replaceNamed(RoutePaths.home);
            });
      },
      child: MgwOSBaseButton(
        width: double.infinity,
        colorBackground: darkBlue,
        onPressed: () {
          setState(() {
            if (_checkValidate(context)) {
              BlocProvider.of<LoginCubit>(context).login(
                  _usernameController.text.trim(),
                  _passwordController.text.trim());
            } else {
              _showPopupError(context);
            }
          });
        },
        cornerRadius: 12.r,
        text: AppLocalizations.of(context)!.lbl_btn_login,
        titleStyle:
            ThemeProvider.instance.textStyleBold16.copyWith(color: neonBlue),
      ),
    );
  }

  bool _checkValidate(BuildContext context) {
    bool isValid = true;
    if (_passwordController.text.isEmpty ||
        !_passwordController.text.isValidPassword()) {
      isValid = false;
      errorPasswordMess = AppLocalizations.of(context)!.lbl_wrong_format;
    }
    if (_usernameController.text.isEmpty) {
      isValid = false;
      errorUsernameMess = AppLocalizations.of(context)!.lbl_wrong_format;
    }
    return isValid;
  }

  _showPopupError(BuildContext context) {
    showMgwOSDialog(context, const Key(''), (dialogContext) {
      return MgwOSPopup(
          title: AppLocalizations.of(context)!.lbl_notes,
          subTitle: AppLocalizations.of(context)!.lbl_must_fill_all,
          buttons: [
            MgwOSAppButton(
                style: AppButtonStyle.fill,
                title: AppLocalizations.of(context)!.lbl_agree_button,
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                })
          ]);
    });
  }
}
