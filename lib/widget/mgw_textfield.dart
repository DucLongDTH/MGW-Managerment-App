import 'package:app_demo_flutter/config/theme_config/theme.dart';
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MgwOSTextField extends StatelessWidget {
  final Key? inputFieldKey;
  final String title;
  final Widget? widgetLeft;
  final Widget? widgetRight;
  final Widget errorWidget;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String?)? onSaved;
  final Function(String)? onChange;
  final VoidCallback? onTap;
  final BoxDecoration? borderDecoration;
  final InputDecoration? inputDecoration;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final double? heightTextField;
  final double? contentPadding;

  const MgwOSTextField(
      {Key? key,
      this.inputFieldKey,
      required this.title,
      this.keyboardType,
      this.controller,
      this.focusNode,
      this.onTap,
      this.onSaved,
      this.onChange,
      this.widgetLeft,
      this.widgetRight,
      this.errorWidget = const SizedBox(),
      this.readOnly = false,
      this.enabled = true,
      this.obscureText = false,
      this.borderDecoration,
      this.inputDecoration,
      this.maxLines = 1,
      this.heightTextField,
      this.inputFormatters,
      this.contentPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          color: greyBackground, borderRadius: BorderRadius.circular(8.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildWidgetLeft(),
          SizedBox(
            width: (widgetLeft != null) ? 16.h : 0,
          ),
          Expanded(
            child: _buildTextForm(),
          ),
          SizedBox(
            width: (widgetRight != null) ? 16.h : 0,
          ),
          widgetRight != null ? _buildWidgetRight() : const SizedBox()
        ],
      ),
    );
  }

  Widget _buildTextForm() {
    return Container(
      height: heightTextField ?? 65.h,
      padding: EdgeInsets.symmetric(vertical: 13.h),
      child: Center(
        child: TextFormField(
          key: inputFieldKey,
          controller: controller,
          readOnly: readOnly,
          enabled: enabled,
          obscureText: obscureText,
          obscuringCharacter: "•",
          maxLines: 1,
          decoration: InputDecoration(
              hintText: title,
              border: InputBorder.none,
              hintStyle: ThemeProvider.instance.textStyleBold14
                  .copyWith(color: greyIcon)),
          style: ThemeProvider.instance.textStyleBold14
              .copyWith(color: Colors.black),
          keyboardType: keyboardType,
          onSaved: onSaved,
          onTap: onTap,
          focusNode: focusNode,
          onChanged: onChange,
          inputFormatters: inputFormatters,
        ),
      ),
    );
  }

  Widget _buildWidgetLeft() {
    return (widgetLeft != null) ? widgetLeft! : const SizedBox.shrink();
  }

  Widget _buildWidgetRight() {
    return (widgetRight != null) ? widgetRight! : const SizedBox.shrink();
  }
}
