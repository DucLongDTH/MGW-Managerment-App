import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MgwOSPopup extends StatelessWidget {
  final String? imagePath;
  final String title;
  final String? subTitle;
  final List<Widget> buttons;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;

  const MgwOSPopup({
    Key? key,
    this.imagePath,
    required this.title,
    this.subTitle,
    required this.buttons,
    this.titleStyle,
    this.subTitleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(34),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            imagePath != null
                ? SvgPicture.asset(
                    imagePath!,
                    width: 82.w,
                    height: 82.h,
                  )
                : const SizedBox(),
            SizedBox(height: 20.h),
            Text(title,
                style: titleStyle ??
                    ThemeProvider.instance.textStyleBold18
                        .copyWith(color: darkBlue),
                textAlign: TextAlign.center),
            SizedBox(height: 10.h),
            Text(
              subTitle ?? "",
              textAlign: TextAlign.center,
              style: subTitleStyle ??
                  ThemeProvider.instance.textStyleMed14.copyWith(color: grey),
            ),
            SizedBox(height: 25.h),
            Column(
              children: buttons
                  .map((e) => Padding(
                        padding: EdgeInsets.all(8.w),
                        child: e,
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
