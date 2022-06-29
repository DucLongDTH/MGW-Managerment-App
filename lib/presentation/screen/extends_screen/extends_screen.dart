import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/widget/base_state.dart';
import 'package:app_demo_flutter/widget/mgw_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';
import 'package:styled_widget/styled_widget.dart';

class ExtendsScreen extends StatefulWidget {
  const ExtendsScreen({Key? key}) : super(key: key);

  @override
  State<ExtendsScreen> createState() => _ExtendsScreenState();
}

class _ExtendsScreenState extends BaseState<ExtendsScreen> {
  @override
  Widget buildLayout(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: white,
        appBar: MgwOSAppBar(
            height: 80.h,
            widgetLeft: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: _getAvatarByName('Nguyen Duc Long'),
            ),
            title: 'Nguyen Duc Long',
            subTitle: 'Admin',
            textColor: white,
            backgroundColor: darkBlue,
            elevation: 0),
        body: Container());
  }

  Widget _getAvatarByName(String name) {
    final listSplistName = name.split(' ');

    final nameShort = listSplistName.first.isNotEmpty
        ? '${(listSplistName.first[0])}${(listSplistName.last[0])}'
        : '--';
    return CircleAvatar(
      backgroundColor: white,
      child: Center(
        child: Text(nameShort,
            style: ThemeProvider.instance.textStyleBold12
                .copyWith(color: darkBlue)),
      ),
    );
  }
}
