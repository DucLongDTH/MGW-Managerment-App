import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/widget/mgw_base_button.dart';
import 'package:flutter/material.dart';

enum AppButtonStyle { fill, border, none, noneUnderline }

class MgwOSAppButton extends StatelessWidget {
  final AppButtonStyle style;
  final String title;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final double? cornerRadius;
  final bool isDisable;
  final TextStyle? titleStyle;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;

  const MgwOSAppButton(
      {Key? key,
      required this.style,
      required this.title,
      required this.onPressed,
      this.width = double.infinity,
      this.height = 48,
      this.cornerRadius = 24,
      this.isDisable = false,
      this.titleStyle,
      this.textColor,
      this.backgroundColor,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _textColor = Colors.transparent;
    var _backgroundColor = Colors.transparent;
    var _borderColor = Colors.transparent;
    var _textDecoration = TextDecoration.none;

    switch (style) {
      case AppButtonStyle.fill:
        _textColor = textColor ?? ThemeProvider.instance.secondaryColor;
        _backgroundColor = backgroundColor ??
            (isDisable
                ? const Color(0xffbdbdbd)
                : ThemeProvider.instance.primaryColor);
        _borderColor = borderColor ?? Colors.transparent;
        _textDecoration = TextDecoration.none;
        break;
      case AppButtonStyle.border:
        _textColor = textColor ??
            (isDisable
                ? const Color(0xffbdbdbd)
                : ThemeProvider.instance.primaryColor);
        _backgroundColor =
            backgroundColor ?? ThemeProvider.instance.secondaryColor;
        _borderColor = borderColor ??
            (isDisable
                ? const Color(0xffbdbdbd)
                : ThemeProvider.instance.primaryColor);
        _textDecoration = TextDecoration.none;
        break;
      case AppButtonStyle.none:
        _textColor = textColor ?? Colors.white;
        _backgroundColor = backgroundColor ?? Colors.transparent;
        _borderColor = borderColor ?? Colors.transparent;
        _textDecoration = TextDecoration.none;
        break;
      case AppButtonStyle.noneUnderline:
        _textColor = textColor ?? Colors.white;
        _backgroundColor = backgroundColor ?? Colors.transparent;
        _borderColor = borderColor ?? Colors.transparent;
        _textDecoration = TextDecoration.underline;
        break;
    }

    return MgwOSBaseButton(
      text: title,
      colorBackground: _backgroundColor,
      onPressed: isDisable ? null : onPressed,
      titleStyle:
          (titleStyle ?? ThemeProvider.instance.textStyleMed16).copyWith(
        color: _textColor,
        decoration: _textDecoration,
      ),
      colorBorder: _borderColor,
      width: width ?? 0,
      height: height ?? 0,
      cornerRadius: cornerRadius ?? 0,
    );
  }
}
