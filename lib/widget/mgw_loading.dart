import 'package:app_demo_flutter/widget/mgw_indicator.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class MgwOSLoading extends StatefulWidget {
  final Widget mainWidget;
  final bool isShowLoading;
  final Size? size;

  const MgwOSLoading(
      {Key? key,
        required this.mainWidget,
        required this.isShowLoading,
        this.size})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MgwOSLoadingState();
  }
}

class _MgwOSLoadingState extends State<MgwOSLoading> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      widget.mainWidget,
      widget.isShowLoading
          ? Center(
        child: MgwOSLoadingIndicator(
          size: widget.size,
        ),
      ).backgroundColor(Colors.transparent)
          : const SizedBox()
    ]);
  }
}
