import 'package:flutter/material.dart';

abstract class SDKActionHandler {
  Future showDialogTokenExpired(BuildContext context, Exception exception);
  Future handleTokenExpired(BuildContext context, Exception exception);
}
