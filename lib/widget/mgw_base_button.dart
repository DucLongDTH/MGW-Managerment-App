import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MgwOSBaseButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final Color colorBackground;
  final Color colorBorder;
  final double? height;
  final double? width;
  final double? cornerRadius;
  final Color colorIcons;
  final VoidCallback? onPressed;
  final String? packageName;
  final TextStyle? titleStyle;

  const MgwOSBaseButton(
      {Key? key,
      required this.text,
      this.iconPath = "",
      required this.colorBackground,
      required this.onPressed,
      this.colorBorder = Colors.transparent,
      this.width,
      this.height,
      this.cornerRadius,
      this.colorIcons = Colors.white,
      this.packageName,
      this.titleStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: _buildStyleButton(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIconButton(),
            SizedBox(
              width: iconPath.isEmpty ? 0 : 10.sp,
            ),
            Text(
              text,
              style:
                  titleStyle ?? TextStyle(fontSize: 16.sp, color: Colors.white),
            ),
          ],
        ));
  }

  ButtonStyle _buildStyleButton() {
    return ElevatedButton.styleFrom(
        elevation: colorBackground == Colors.transparent ? 0 : null,
        enableFeedback: colorBackground == Colors.transparent ? false : null,
        primary: colorBackground,
        shadowColor:
            colorBackground == Colors.transparent ? Colors.transparent : null,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.0,
            color: colorBorder,
          ),
          borderRadius: BorderRadius.circular(cornerRadius ?? 30.r),
        ),
        fixedSize: Size(width ?? 200.w, height ?? 48.h));
  }

  Widget _buildIconButton() {
    return (iconPath.isNotEmpty)
        ? SvgPicture.asset(
            iconPath,
            package: packageName,
            color: colorIcons,
          )
        : const SizedBox();
  }
}
