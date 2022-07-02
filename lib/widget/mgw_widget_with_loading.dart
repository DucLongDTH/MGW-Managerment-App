import 'package:app_demo_flutter/widget/mgw_indicator.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class MgwOSWidgetWithLoading extends StatefulWidget {
  final Size? size;

  const MgwOSWidgetWithLoading({Key? key, this.size}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MgwOSWidgetWithLoadingState();
  }
}

class _MgwOSWidgetWithLoadingState extends State<MgwOSWidgetWithLoading> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MgwOSLoadingIndicator(
        size: widget.size,
      ),
    ).backgroundColor(Colors.transparent);
  }
}
