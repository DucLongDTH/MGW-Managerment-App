import 'package:app_demo_flutter/config/dio_config/dio_error_intercaptors.dart';
import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/constant/dialog_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:app_demo_flutter/l10n/gen/app_localizations.dart';
import 'package:app_demo_flutter/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:app_demo_flutter/presentation/cubit/login_cubit/login_state.dart';
import 'package:app_demo_flutter/widget/base/base_state.dart';
import 'package:app_demo_flutter/widget/mgw_app_button.dart';
import 'package:app_demo_flutter/widget/mgw_appbar.dart';
import 'package:app_demo_flutter/widget/mgw_base_button.dart';
import 'package:app_demo_flutter/widget/mgw_popup.dart';
import 'package:app_demo_flutter/widget/mgw_textfield.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen> {
  bool _isHidePassword = true;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  Widget buildLayout(BuildContext context) {
    return Scaffold(
      appBar: MgwOSAppBar(
          title: AppLocalizations.of(context)!.lbl_register,
          textColor: darkBlue,
          backgroundColor: white,
          centerTitle: true,
          elevation: 1),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          height: MediaQuery.of(context).size.height - 56.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 50.h),
              _buildCardLogin(),
              const Spacer(),
              _buildButtonLogin(),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardLogin() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextFieldEmail(),
        SizedBox(
          height: 15.h,
        ),
        _buildTextFieldUserName(),
        SizedBox(
          height: 15.h,
        ),
        _buildTextFieldPassword(),
      ],
    );
  }

  Widget _buildTextFieldEmail() {
    return MgwOSTextField(
      inputFieldKey: const Key('txtEmail'),
      title: AppLocalizations.of(context)!.lbl_email,
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      widgetLeft: const Icon(
        Icons.email,
        color: greyIcon,
      ),
      onChange: (value) {},
      onSaved: (value) {},
    );
  }

  Widget _buildTextFieldUserName() {
    return MgwOSTextField(
      inputFieldKey: const Key('txtUserName'),
      title: AppLocalizations.of(context)!.lbl_username,
      keyboardType: TextInputType.text,
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
        // _isLoading.value = false;
        state.maybeWhen(
            orElse: () {},
            loading: () {
              // _isLoading.value = true;
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
              AutoRouter.of(context).pop();
            });
      },
      child: MgwOSBaseButton(
        width: double.infinity,
        colorBackground: darkBlue,
        onPressed: () {
          // BlocProvider.of<LoginCubit>(context).login(
          //     _usernameController.text.trim(), _passwordController.text.trim());
        },
        cornerRadius: 12.r,
        text: AppLocalizations.of(context)!.lbl_btn_register,
        titleStyle:
            ThemeProvider.instance.textStyleBold18.copyWith(color: neonBlue),
      ),
    );
  }
}
