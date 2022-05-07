import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:flutter/material.dart';

class MgwOSAppBar extends StatelessWidget implements PreferredSizeWidget{

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
        this.elevation})
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
      leading: InkWell(
        key: const Key('btnBack'),
        onTap: onClickIconLeft,
        child: widgetLeft,
      ),
      title: Text(
        title ?? '',
        style:
        ThemeProvider.instance.textStyleBold18.copyWith(color: textColor),
      ),
      backgroundColor: backgroundColor ?? white,
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height!);
}
