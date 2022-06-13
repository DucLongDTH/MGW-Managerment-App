import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showMgwOSDialog(BuildContext context, Key? key,
    Widget Function(BuildContext _dialogContext) child) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (dialogContext) => WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              key: key,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.r))),
              child: child(dialogContext),
            ),
          ));
}

TextStyle buildTitlePopupStyle() =>
    ThemeProvider.instance.textStyleBold18.copyWith(color: darkBlue);

TextStyle buildSubTitlePopupStyle() =>
    ThemeProvider.instance.textStyleMed14.copyWith(color: grey);
