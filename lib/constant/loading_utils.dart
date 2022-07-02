import 'package:app_demo_flutter/widget/mgw_widget_with_loading.dart';
import 'package:flutter/material.dart';

Widget showLoading(bool isShowLoading) {
  if (isShowLoading) {
    return const MgwOSWidgetWithLoading();
  }
  return const SizedBox.shrink();
}
