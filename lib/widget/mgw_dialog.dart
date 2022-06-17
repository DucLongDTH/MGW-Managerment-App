import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MgwDialogWidget extends StatelessWidget {
  final String? imagePath;
  final String title;
  final String? message;
  final Widget? styledMessage;
  final List<Widget> buttons;
  final String? packageName;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;

  const MgwDialogWidget({
    Key? key,
    this.imagePath,
    required this.title,
    this.message,
    this.styledMessage,
    required this.buttons,
    this.titleStyle,
    this.messageStyle,
    this.packageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 32.h, bottom: 24.h, left: 20.w, right: 20.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: titleStyle ??
                  Theme.of(context).textTheme.dialogTitleTextStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            imagePath != null
                ? SvgPicture.asset(
                    imagePath!,
                    package: packageName,
                    width: 60.w,
                    height: 60.w,
                  )
                : const SizedBox(),
            SizedBox(height: 24.h),
            _buildMessage(context),
            SizedBox(height: 24.h),
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

  Widget _buildMessage(BuildContext context) {
    return styledMessage ??
        Text(
          message ?? '',
          textAlign: TextAlign.center,
          style: messageStyle ??
              Theme.of(context).textTheme.dialogMessageTextStyle,
        );
  }
}
