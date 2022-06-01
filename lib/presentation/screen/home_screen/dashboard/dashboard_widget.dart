import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/gen/assets.gen.dart';
import 'package:app_demo_flutter/presentation/screen/home_screen/dashboard/bar_chart_sample.dart';
import 'package:app_demo_flutter/widget/mgw_appbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
              child: Icon(
            Icons.add,
            size: 30.w,
            color: white,
          )).padding(right: 8.w),
          title: 'Home',
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
          Expanded(flex: 1, child: BarChartSample1())
        ],
      )),
    );
  }
}
