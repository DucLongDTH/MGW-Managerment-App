import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/l10n/gen/app_localizations.dart';
import 'package:app_demo_flutter/widget/base_state.dart';
import 'package:app_demo_flutter/widget/mgw_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_widget/styled_widget.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({Key? key}) : super(key: key);

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends BaseState<BillScreen> {
  @override
  Widget buildLayout(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: white,
        appBar: MgwOSAppBar(
            widgetRight: GestureDetector(
                child: Icon(
              Icons.add,
              size: 30.w,
              color: white,
            )).padding(right: 8.w),
            title: AppLocalizations.of(context)!.lbl_title_bill,
            textColor: white,
            backgroundColor: darkBlue,
            elevation: 0),
        body: Container());
  }
}
