import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/constant/dialog_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:app_demo_flutter/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:app_demo_flutter/presentation/cubit/login_cubit/login_state.dart';
import 'package:app_demo_flutter/widget/mgw_appbar.dart';
import 'package:app_demo_flutter/widget/mgw_button.dart';
import 'package:app_demo_flutter/widget/mgw_loading.dart';
import 'package:app_demo_flutter/widget/mgw_popup.dart';
import 'package:app_demo_flutter/widget/mgw_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:styled_widget/styled_widget.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late LoginCubit _cubit;
  late String title;
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  @override
  void initState() {
    _cubit = BlocProvider.of<LoginCubit>(context);
    title = 'GET DATA FROM API DEMO';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: white,
          appBar: MgwOSAppBar(
              title: 'Home',
              textColor: darkBlue,
              backgroundColor: white,
              widgetLeft: Row(
                children: [
                  SizedBox(width: 16.w),
                  Image.asset(
                    Assets.images.logo.path,
                    width: 25.w,
                    height: 30.h,
                    colorBlendMode: BlendMode.clear,
                    errorBuilder: (_, __, ___) {
                      return const SizedBox.shrink();
                    },
                  )
                ],
              ),
              elevation: 0),
          body: ValueListenableBuilder<bool>(
            valueListenable: _isLoading,
            builder: (context, value, child) {
              return Center(
                child: MgwOSLoading(
                  mainWidget: child!,
                  isShowLoading: value,
                ),
              );
            },
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 30.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MgwOSTextField(
                    inputFieldKey: const Key('txtUserName'),
                    title: 'UserName',
                    keyboardType: TextInputType.emailAddress,
                    controller: TextEditingController(),
                    widgetLeft: SvgPicture.asset(
                      Assets.icons.icUser,
                      width: 21.w,
                      height: 21.h,
                      color: greyIcon,
                    ),
                    onChange: (value) {},
                    onSaved: (value) {},
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  MgwOSTextField(
                    inputFieldKey: const Key('txtPassword'),
                    title: 'Password',
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(),
                    obscureText: true,
                    widgetLeft: SvgPicture.asset(
                      Assets.icons.icPassword,
                      width: 21.w,
                      height: 21.h,
                      color: greyIcon,
                    ),
                    widgetRight: SvgPicture.asset(
                      Assets.icons.icVisible,
                      width: 21.w,
                      height: 21.h,
                      color: greyIcon,
                    ),
                    onChange: (value) {},
                    onSaved: (value) {},
                  ),
                  SizedBox(
                    height: 550.h,
                  ),
                  Text(title).padding(),
                  SizedBox(
                    height: 150.h,
                  ),
                  BlocListener<LoginCubit, LoginState>(
                    listener: (context, state) {
                      _isLoading.value = false;
                      state.maybeWhen(
                          orElse: () {},
                          loading: () {
                            _isLoading.value = true;
                          },
                          error: (err) {
                            setState(() {
                              title = err.toString();
                            });
                          },
                          success: () {
                            setState(() {
                              title = 'GET DATA SUCCESS';
                            });
                            _showPopup();
                          });
                    },
                    child: MgwOSButton(
                      width: double.infinity,
                      colorBackground: darkBlue,
                      onPressed: () {
                        // _cubit.login();
                      },
                      text: 'DEMO GET DATA',
                      titleStyle: ThemeProvider.instance.textStyleBold18
                          .copyWith(color: white),
                    ).padding(horizontal: 16.w),
                  ),
                  SizedBox(height: 50.h)
                ],
              ),
            ),
          ),
        ));
  }

  void _showPopup() {
    showMgwOSDialog(context, null, ((_dialogContext) {
      return MgwOSPopup(
        title: "Success",
        titleStyle: buildTitlePopupStyle(),
        subTitle: "Get Api Success",
        subTitleStyle: buildSubTitlePopupStyle(),
        buttons: [
          MgwOSButton(
            text: 'OK',
            colorBackground: darkBlue,
            onPressed: () {
              Navigator.pop(_dialogContext);
            },
            cornerRadius: 30.r,
            height: 48.h,
            titleStyle:
                ThemeProvider.instance.textStyleMed14.copyWith(color: white),
            width: 343.w,
          )
        ],
      );
    }));
  }
}
