import 'package:app_demo_flutter/config/dialog_manager/dialog_manager.dart';
import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

showMgwOSDialog(BuildContext context, Key? key,
    Widget Function(BuildContext _dialogContext) child) {
  return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (dialogContext) => WillPopScope(
            onWillPop: () async => true,
            child: Dialog(
              key: key,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.r))),
              child: child(dialogContext),
            ),
          ));
}

Future dialogUtils(BuildContext context, Exception value) {
  return GetIt.instance<DialogManager>().showErrorDialog(context, value);
}

Future dialogOptionUtils(BuildContext context, DialogOption option) {
  return GetIt.instance<DialogManager>().showDialogWithOption(context, option);
}

Future handleDefaultAction(BuildContext context, Exception value) {
  return GetIt.instance<DialogManager>().defaultButtonAction(context, value);
}

Future showDialogDefaultAction(BuildContext context, Exception value) {
  return dialogUtils(context, value)
      .then((_) => handleDefaultAction(context, value));
}

TextStyle buildTitlePopupStyle() =>
    ThemeProvider.instance.textStyleBold18.copyWith(color: darkBlue);

TextStyle buildSubTitlePopupStyle() =>
    ThemeProvider.instance.textStyleMed14.copyWith(color: grey);
