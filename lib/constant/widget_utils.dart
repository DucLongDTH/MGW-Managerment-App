import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:flutter/material.dart';

Widget buildErrorForm(String errorMess) {
  return Text(
    errorMess,
    style: ThemeProvider.instance.textStyleMed12.copyWith(color: red),
  );
}
