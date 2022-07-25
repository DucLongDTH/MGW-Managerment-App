import 'package:app_demo_flutter/config/dio_config/dio_error_intercaptors.dart';
import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/constant/dialog_utils.dart';
import 'package:app_demo_flutter/constant/validator_utils.dart';
import 'package:app_demo_flutter/constant/widget_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:app_demo_flutter/l10n/gen/app_localizations.dart';
import 'package:app_demo_flutter/presentation/cubit/register_cubit/register_cubit.dart';
import 'package:app_demo_flutter/presentation/cubit/register_cubit/register_state.dart';
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
  bool _isHidePasswordAgain = true;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordAgainController;
  late TextEditingController _emailController;
  String errorUsernameMess = '';
  String errorEmailMess = '';
  String errorPasswordMess = '';
  String errorPasswordAgainMess = '';

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordAgainController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _usernameController.dispose();
    _passwordAgainController.dispose();
    _emailController.dispose();
    super.dispose();
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
              _buildButtonLogin(context),
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
        _buildTextFieldUserName(),
        SizedBox(
          height: 8.h,
        ),
        _buildTextFieldEmail(),
        SizedBox(
          height: 8.h,
        ),
        _buildTextFieldPassword(),
        SizedBox(
          height: 8.h,
        ),
        _buildTextFieldPasswordAgain()
      ],
    );
  }

  Widget _buildTextFieldEmail() {
    return MgwOSTextField(
      errorWidget: buildErrorForm(errorEmailMess),
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
      errorWidget: buildErrorForm(errorUsernameMess),
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
  }

  Widget _buildTextFieldPasswordAgain() {
    return MgwOSTextField(
      errorWidget: buildErrorForm(errorPasswordAgainMess),
      inputFieldKey: const Key('txtPasswordAgain'),
      title: AppLocalizations.of(context)!.lbl_password_again,
      keyboardType: TextInputType.text,
      controller: _passwordAgainController,
      obscureText: _isHidePasswordAgain,
      widgetLeft: SvgPicture.asset(
        Assets.icons.icPassword,
        width: 21.w,
        height: 21.h,
        color: greyIcon,
      ),
      widgetRight: GestureDetector(
        onTap: () {
          setState(() {
            _isHidePasswordAgain = !_isHidePasswordAgain;
          });
        },
        child: SvgPicture.asset(
          _isHidePasswordAgain ? Assets.icons.icVisible : Assets.icons.icHidden,
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
  }

  Widget _buildButtonLogin(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        loadingOverlay.hide();
        state.maybeWhen(
            orElse: () {},
            loading: () {
              loadingOverlay.show(context);
            },
            error: (err) {
              if (err is BadRequestException) {
                showMgwOSDialog(context, const Key(''), (dialogContext) {
                  return MgwOSPopup(
                      title: AppLocalizations.of(context)!.lbl_error_title,
                      subTitle:
                          AppLocalizations.of(context)!.lbl_duplicate_account,
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
        onPressed: _onRegisterButton,
        cornerRadius: 12.r,
        text: AppLocalizations.of(context)!.lbl_btn_register,
        titleStyle:
            ThemeProvider.instance.textStyleBold18.copyWith(color: neonBlue),
      ),
    );
  }

  _onRegisterButton() {
    if (_checkValidate(context)) {
      BlocProvider.of<RegisterCubit>(context).register(
          _usernameController.text.trim(),
          _emailController.text.trim(),
          _passwordController.text.trim());
    }
  }

  bool _checkValidate(BuildContext context) {
    bool isValid = true;
    formatErrorMessage();
    if (_emailController.text.isEmpty ||
        !_emailController.text.isValidEmail() ||
        _emailController.text.length > 50) {
      isValid = false;
      errorEmailMess = AppLocalizations.of(context)!.lbl_wrong_format;
    }
    if (_passwordController.text.isEmpty ||
        !_passwordController.text.isValidPassword()) {
      isValid = false;
      errorPasswordMess = AppLocalizations.of(context)!.lbl_wrong_format;
    }
    if (_passwordAgainController.text.isEmpty ||
        !_passwordAgainController.text.isValidEmail()) {
      isValid = false;
      errorPasswordAgainMess = AppLocalizations.of(context)!.lbl_wrong_format;
    }
    if (_passwordAgainController.text != _passwordController.text) {
      isValid = false;
      errorPasswordAgainMess =
          AppLocalizations.of(context)!.lbl_password_not_mactch;
    }
    if (_usernameController.text.isEmpty) {
      isValid = false;
      errorUsernameMess = AppLocalizations.of(context)!.lbl_wrong_format;
    }
    if (isValid == false) {
      _showPopupError(context);
    }
    setState(() {});
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

  void formatErrorMessage() {
    errorUsernameMess = '';
    errorEmailMess = '';
    errorPasswordMess = '';
    errorPasswordAgainMess = '';
  }
}
