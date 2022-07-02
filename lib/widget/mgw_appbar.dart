import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_widget/styled_widget.dart';

class MgwOSAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final String? icon;
  final String? title;
  final double? height;
  final VoidCallback? onClickIconLeft;
  final VoidCallback? onClickIconRight;
  final Widget? widgetRight;
  final Widget? widgetLeft;
  final double? elevation;
  final String? subTitle;
  final bool? centerTitle;

  const MgwOSAppBar(
      {Key? key,
      this.backgroundColor,
      this.textColor = Colors.white,
      this.icon,
      this.title = '',
      this.height = kToolbarHeight,
      this.onClickIconLeft,
      this.iconColor = Colors.black,
      this.onClickIconRight,
      this.widgetRight,
      this.widgetLeft,
      this.elevation,
      this.subTitle,
      this.centerTitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation ?? 2,
      shadowColor: greyShadow,
      // actions: menuItem,
      toolbarHeight: preferredSize.height,
      iconTheme: IconThemeData(
        color: textColor,
      ),
      actions: [
        (widgetRight != null)
            ? GestureDetector(
                onTap: onClickIconRight,
                child: widgetRight,
              )
            : const SizedBox()
      ],
      leading: widgetLeft != null
          ? InkWell(
              key: const Key('btnBack'),
              onTap: onClickIconLeft,
              child: widgetLeft,
            )
          : null,
      title: subTitle == null
          ? Text(
              title ?? '',
              style: ThemeProvider.instance.textStyleBold18
                  .copyWith(color: textColor),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? '',
                  style: ThemeProvider.instance.textStyleBold18
                      .copyWith(color: textColor),
                ).padding(bottom: 4.h),
                subTitle?.isNotEmpty == true
                    ? Text(subTitle ?? '',
                        style: ThemeProvider.instance.textStyleMed14
                            .copyWith(color: Colors.yellow))
                    : const SizedBox.shrink()
              ],
            ),
      backgroundColor: backgroundColor ?? white,
      centerTitle: centerTitle ?? false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height!);
}
