import 'package:app_demo_flutter/config/dialog_manager/default_dialog_mixins.dart';
import 'package:app_demo_flutter/config/dialog_manager/dialog_manager.dart';
import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/l10n/gen/app_localizations.dart';
import 'package:app_demo_flutter/widget/mgw_app_button.dart';
import 'package:app_demo_flutter/widget/mgw_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDialogManager extends DialogManager with DefaultDialogMixin {
  @override
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
    return Builder(builder: (context) {
      return WillPopScope(
        onWillPop: () => Future.value(barrierDismissible),
        child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.r))),
            child: MgwDialogWidget(
              title: title,
              titleStyle: Theme.of(context).textTheme.dialogTitleTextStyle,
              messageStyle: Theme.of(context).textTheme.dialogMessageTextStyle,
              message: subTitle,
              styledMessage: styledMessage,
              imagePath: imagePath,
              packageName: packageName,
              buttons: buttons,
            )),
      );
    });
  }

  @override
  Widget buildOKButton(
      BuildContext context, String buttonTitle, DialogOption option) {
    return MgwOSAppButton(
      key: const Key('btnOk'),
      style: AppButtonStyle.fill,
      title: buttonTitle,
      onPressed: () {
        Navigator.pop(context, option);
      },
    );
  }

  @override
  Widget buildCancelButton(BuildContext context, String buttonTitle) {
    return InkWell(
      key: const Key('btnCancel'),
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Text(
          buttonTitle,
          style: Theme.of(context).textTheme.primaryTextStyle.copyWith(
                color: ThemeProvider.instance.primaryColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  @override
  Future showErrorDialog(BuildContext context, Exception exception,
      {bool handleUnAuthorized = true}) async {
    // if (handleUnAuthorized && exception is UnauthorizedException) {
    //   final result = await GetIt.instance
    //       .get<SDKActionHandler>()
    //       .showDialogTokenExpired(context, exception);
    //   if (result != null && result == true) {
    //     return;
    //   }
    // }
    final dialogErrorOption =
        DialogErrorOptions.getDialogErrorOption(context, exception);
    dialogErrorOption.exception = exception;
    dialogErrorOption.buttonTitle =
        AppLocalizations.of(context)!.lbl_agree_button;
    // dialogErrorOption.imagePath = Assets.icons.icError;
    return showDialogWithOption(context, (dialogErrorOption));
  }

  @override
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
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: child(dialogContext),
              ),
            ));
  }
}
