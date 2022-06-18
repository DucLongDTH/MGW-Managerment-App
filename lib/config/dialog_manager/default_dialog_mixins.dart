import 'dart:async';
import 'dart:io';

import 'package:app_demo_flutter/config/core/action_handler.dart';
import 'package:app_demo_flutter/config/dialog_manager/dialog_manager.dart';
import 'package:app_demo_flutter/config/dio_config/dio_error_intercaptors.dart';
import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/dialog_utils.dart';
import 'package:app_demo_flutter/widget/mgw_app_button.dart';
import 'package:app_demo_flutter/widget/mgw_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

mixin DefaultDialogMixin {
  Future showDialogWithOption(
      BuildContext context, DialogOption? dialogOption) {
    final option = dialogOption ?? DialogOption();
    final title = option.title;
    final description = option.message;
    final buttonTitle = option.buttonTitle;
    final buttonSubTitle = option.buttonSubTitle;
    final barrierDismissible = option.barrierDismissible;
    final barrierColor = option.getBarrierColor();
    final useRootNavigator = option.useRootNavigator;

    return showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        useRootNavigator: useRootNavigator,
        builder: (dialogContext) {
          final buttons = <Widget>[];
          buttons.add(buildOKButton(dialogContext, buttonTitle, option));
          if (buttonSubTitle != null) {
            buttons.add(buildCancelButton(dialogContext, buttonSubTitle));
          }

          return buildDialogWidget(
              title: title,
              titleStyle: buildTitlePopupStyle(),
              subTitleStyle: buildSubTitlePopupStyle(),
              subTitle: description,
              styledMessage: option.styledMessage,
              imagePath: option.imagePath,
              packageName: option.packageName,
              buttons: buttons,
              barrierDismissible: barrierDismissible);
        });
  }

  Widget buildDialogWidget({
    String? imagePath,
    String title = '',
    String? subTitle,
    Widget? styledMessage,
    List<Widget> buttons = const [],
    String? packageName,
    TextStyle? titleStyle,
    TextStyle? subTitleStyle,
    bool barrierDismissible = false,
  }) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.r))),
      child: WillPopScope(
        onWillPop: () => Future.value(barrierDismissible),
        child: MgwOSPopup(
          title: title,
          titleStyle: buildTitlePopupStyle(),
          subTitleStyle: buildSubTitlePopupStyle(),
          subTitle: subTitle,
          imagePath: imagePath,
          buttons: buttons,
        ),
      ),
    );
  }

  Future showErrorDialog(BuildContext context, Exception exception,
      {bool handleUnAuthorized = true}) async {
    if (handleUnAuthorized && exception is UnauthorizedException) {
      final result = await GetIt.instance
          .get<SDKActionHandler>()
          .showDialogTokenExpired(context, exception);
      if (result != null && result == true) {
        return;
      }
    }
    final dialogErrorOption =
        DialogErrorOptions.getDialogErrorOption(context, exception);
    dialogErrorOption.exception = exception;
    return showDialogWithOption(context, (dialogErrorOption));
  }

  Future defaultButtonAction(BuildContext context, Exception exception) {
    if (exception is ServerUnderMaintainErrorException) {
      exit(0);
    } else if (exception is UnauthorizedException) {
      return GetIt.instance
          .get<SDKActionHandler>()
          .handleTokenExpired(context, exception);
    }
    return Future.value(null);
  }

  Widget buildOKButton(
      BuildContext context, String buttonTitle, DialogOption option) {
    return MgwOSAppButton(
      key: const Key('btnOk'),
      style: AppButtonStyle.fill,
      title: buttonTitle,
      titleStyle: ThemeProvider.instance.textStyleMed14,
      onPressed: () {
        Navigator.pop(context, option);
      },
    );
  }

  Widget buildCancelButton(BuildContext context, String buttonTitle) {
    return InkWell(
      key: const Key('btnCancel'),
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.h),
        child: Text(
          buttonTitle,
          style: ThemeProvider.instance.textStyleMed14,
        ),
      ),
    );
  }

  Future<dynamic> showFinOSDialog(
    BuildContext context,
    Key? key,
    Widget Function(BuildContext _dialogContext) child, {
    Color? backgroundColor = Colors.white,
    double? elevation = 24,
    bool barrierDismissible = false,
    ShapeBorder? shapeBorder,
  }) {
    return showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (dialogContext) => WillPopScope(
              onWillPop: () async => barrierDismissible,
              child: Dialog(
                backgroundColor: backgroundColor,
                elevation: elevation,
                key: key,
                shape: shapeBorder ??
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.r))),
                child: child(dialogContext),
              ),
            ));
  }
}
