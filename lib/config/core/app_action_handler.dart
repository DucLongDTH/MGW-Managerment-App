import 'package:app_demo_flutter/config/core/action_handler.dart';
import 'package:app_demo_flutter/config/dialog_manager/dialog_manager.dart';
import 'package:app_demo_flutter/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppActionHandler extends SDKActionHandler {
  @override
  Future handleTokenExpired(BuildContext context, Exception exception) {
    /// Fill webOrigin only when your current origin is different than the app's origin
    Navigator.pushNamedAndRemoveUntil(
        context, RoutePaths.login, ModalRoute.withName('/'));
    return Future.value(true);
  }

  @override
  Future showDialogTokenExpired(
      BuildContext context, Exception exception) async {
    await GetIt.instance
        .get<DialogManager>()
        .showErrorDialog(context, exception, handleUnAuthorized: false);
    return Future.value(true);
  }
}
