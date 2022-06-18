import 'dart:async';
import 'package:app_demo_flutter/config/dio_config/connecttivity_util.dart';
import 'package:app_demo_flutter/config/dio_config/dio_error_intercaptors.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/l10n/gen/app_localizations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class DialogManager {
  Future showDialogWithOption(BuildContext context, DialogOption? dialogOption);

  Future defaultButtonAction(BuildContext context, Exception exception);

  Future showErrorDialog(BuildContext context, Exception exception,
      {bool handleUnAuthorized = true});

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
  });

  Widget buildOKButton(
      BuildContext context, String buttonTitle, DialogOption option);

  Widget buildCancelButton(BuildContext context, String buttonTitle);

  Future<dynamic> showFinOSDialog(
    BuildContext context,
    Key? key,
    Widget Function(BuildContext _dialogContext) child, {
    Color? backgroundColor = Colors.white,
    double? elevation = 24,
    bool barrierDismissible = false,
  });
}

class DialogErrorOptions {
  static DialogOption baseOptions(BuildContext context) => DialogOption(
        title: AppLocalizations.of(context)!.lbl_error_title,
        message: AppLocalizations.of(context)!.lbl_server_error,
        buttonTitle: AppLocalizations.of(context)!.lbl_agree_button,
        // imagePath: Assets.icons.icError,
      );

  static DialogOption badRequestException(BuildContext context) =>
      baseOptions(context)
        ..message = AppLocalizations.of(context)!.lbl_errorMsg400;

  static DialogOption unAuthorizedException(BuildContext context) =>
      baseOptions(context)
        ..message = AppLocalizations.of(context)!.lbl_errorMsg401;

  static DialogOption serverUnderMaintainException(BuildContext context) =>
      baseOptions(context)
        ..title = AppLocalizations.of(context)!.lbl_errorMsg503_title
        ..message = AppLocalizations.of(context)!.lbl_errorMsg503
        ..buttonTitle = AppLocalizations.of(context)!.lbl_agree_button;

  static DialogOption noInternetException(BuildContext context) =>
      baseOptions(context)
        ..message = AppLocalizations.of(context)!.lbl_errorMsgConnection
        ..buttonTitle = AppLocalizations.of(context)!.lbl_understand;

  static DialogOption getDialogErrorOption(
      BuildContext context, Exception exception) {
    if (exception is BadRequestException) {
      return badRequestException(context);
    } else if (exception is UnauthorizedException) {
      return unAuthorizedException(context);
    } else if (exception is ServerUnderMaintainErrorException) {
      return serverUnderMaintainException(context);
    } else if (exception is NoInternetConnectionException ||
        exception is DeadlineExceededException) {
      return noInternetException(context);
    } else {
      return baseOptions(context);
    }
  }

  static DioError fakeDioError() {
    final fakeRqOptions = RequestOptions(path: '');
    final fakeResponse =
        Response(statusCode: 503, requestOptions: fakeRqOptions);
    return DioError(requestOptions: fakeRqOptions, response: fakeResponse);
  }

  static Future<DioError> extractDioError(Exception e) async {
    final fakerError = fakeDioError();
    if (e is DioError && e.response != null) {
      if (e.response?.statusCode == 401) {
        return UnauthorizedException(e);
      } else if (e.response?.statusCode == 503) {
        return ServerUnderMaintainErrorException(e);
      } else {
        return OtherException(e);
      }
    } else {
      if (e is DeadlineExceededException) {
        return e;
      }
      bool hasInternet =
          await ConnectivityUtil.getInstance().hasInternetInternetConnection();
      if (!hasInternet) {
        return NoInternetConnectionException(fakerError);
      } else {
        return OtherException(fakerError);
      }
    }
  }
}

class DialogOption {
  String title;
  String message;
  String buttonTitle;
  String? buttonSubTitle;
  bool barrierDismissible;
  String? barrierColor;
  bool useRootNavigator;
  String? imagePath;
  String? packageName;
  Exception? exception;
  Widget? styledMessage;

  DialogOption({
    this.title = '--',
    this.message = '--',
    this.buttonTitle = '--',
    this.buttonSubTitle,
    this.barrierDismissible = false,
    this.barrierColor,
    this.useRootNavigator = false,
    this.imagePath,
    this.packageName,
    this.exception,
    this.styledMessage,
  });

  Color? getBarrierColor() {
    return barrierColor == null
        ? Colors.black54
        : HexColor.fromHex(barrierColor!);
  }
}
