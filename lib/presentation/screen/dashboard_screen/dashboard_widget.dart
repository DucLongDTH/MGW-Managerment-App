import 'package:app_demo_flutter/config/core/shared_preferences.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/constant/key_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:app_demo_flutter/l10n/gen/app_localizations.dart';
import 'package:app_demo_flutter/presentation/screen/dashboard_screen/bar_chart_sample.dart';
import 'package:app_demo_flutter/widget/mgw_appbar.dart';
import 'package:app_demo_flutter/widget/mgw_base_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:app_demo_flutter/di/app_di.dart' as di;

class DashBoardWidget extends StatefulWidget {
  const DashBoardWidget({Key? key}) : super(key: key);

  @override
  State<DashBoardWidget> createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MgwOSAppBar(
          widgetRight: GestureDetector(
              child: SvgPicture.asset(
            Assets.icons.icNoti,
            width: 30.w,
            color: Colors.yellowAccent,
          )).padding(right: 8.w),
          title: AppLocalizations.of(context)!.lbl_title_dashboard,
          textColor: white,
          backgroundColor: darkBlue,
          elevation: 0),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expanded(
          //   flex: 1,
          //   child: SfCartesianChart(
          //     backgroundColor: white,
          //     borderColor: black,
          //     plotAreaBackgroundColor: grey,
          //     plotAreaBorderWidth: 8,
          //   ),
          // ),
          // const Expanded(flex: 1, child: BarChartSample1()),
          // Expanded(
          //     flex: 1,
          //     child: MgwOSBaseButton(
          //         text: 'GET TOKEN',
          //         colorBackground: red,
          //         onPressed: () async {
          //           final token = await di
          //               .sl<AppSharedPreferences>()
          //               .getString(authTokenKey);
          //           debugPrint('token: $token');
          //         }))
        ],
      )),
    );
  }
}
