import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:flutter/material.dart';

Widget getAvatarByName(String name) {
  final listSplistName = name.split(' ');
  final nameShort = listSplistName.first.isNotEmpty
      ? '${(listSplistName.first[0])}${(listSplistName.last[0])}'
      : '--';
  return CircleAvatar(
    backgroundColor: white,
    child: Center(
      child: Text(nameShort,
          style:
              ThemeProvider.instance.textStyleBold12.copyWith(color: darkBlue)),
    ),
  );
}
