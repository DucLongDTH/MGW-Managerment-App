import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MgwOSLoadingIndicator extends StatelessWidget {
  final Size? size;

  const MgwOSLoadingIndicator({Key? key, this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var filePath = "assets/loading.json";
    return Lottie.asset(filePath,
        repeat: true,
        reverse: false,
        animate: true,
        width: size?.width ?? 70.w,
        height: size?.width ?? 70.h);
  }
}
