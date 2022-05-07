
import 'package:app_demo_flutter/constant/colors_utils.dart';
import 'package:app_demo_flutter/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeProvider {
  static const defaultFontFamily = FontFamily.josefin;

  ThemeProvider._privateConstructor();

  static final ThemeProvider instance = ThemeProvider._privateConstructor();

  late ThemeData _themeData;

  ThemeData get themeData => _themeData;

  late Color _primaryColor;
  late Color _secondaryColor;
  late TextStyle _textStyleBold32;
  late TextStyle _textStyleBold26;
  late TextStyle _textStyleBold24;
  late TextStyle _textStyleBold20;
  late TextStyle _textStyleBold18;
  late TextStyle _textStyleBold16;
  late TextStyle _textStyleBold14;
  late TextStyle _textStyleBold12;

  late TextStyle _textStyleMed32;
  late TextStyle _textStyleMed26;
  late TextStyle _textStyleMed24;
  late TextStyle _textStyleMed20;
  late TextStyle _textStyleMed18;
  late TextStyle _textStyleMed16;
  late TextStyle _textStyleMed14;
  late TextStyle _textStyleMed12;
  late TextStyle _textStyleMed10;

  void initAppTheme(){
    _themeData = _buildAppTheme();
  }

  ThemeData _buildAppTheme() {
    _portraitModeOnly();
    final baseTheme = ThemeData.light();
    final baseTextStyle = TextStyle(
        fontFamily: defaultFontFamily,
        color: Colors.black,
        fontWeight: FontWeight.w500);
    _initTextStyle(baseTextStyle);
    _primaryColor = white;
    return baseTheme.copyWith(
      // Define the default brightness and colors.
      // brightness: Brightness.dark,
      primaryColor: _primaryColor,
      // Define the default font family.
      // fontFamily: 'Georgia',
      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: baseTheme.textTheme.copyWith(
        headline1: textStyleBold32,
        headline2: textStyleBold24,
        headline3: textStyleBold18,
        headline4: textStyleBold18,
        headline5: textStyleBold18,
        headline6: textStyleBold16,
        subtitle1: textStyleMed16,
        subtitle2: textStyleMed14,
        bodyText1: textStyleMed16,
        bodyText2: textStyleMed14,
        caption: textStyleMed12,
        button: textStyleMed14,
        overline: textStyleMed12,
      ),
      // textSelectionTheme: baseTheme.textSelectionTheme.copyWith(
      //   cursorColor: Colors.black,
      //   selectionColor: Color.lerp(_primaryColor, Colors.white, 0.25),
      //   selectionHandleColor: _secondaryColor,
      // ),
      // buttonTheme: baseTheme.buttonTheme.copyWith(
      //   buttonColor: _secondaryColor,
      //   textTheme: ButtonTextTheme.primary,
      // ),
      // appBarTheme: baseTheme.appBarTheme.copyWith(
      //   backgroundColor: _primaryColor,
      //   toolbarTextStyle: textStyleBold18,
      //   systemOverlayStyle:
      //   const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      // ),
    );
  }

  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _initTextStyle(TextStyle baseTextStyle) {
    final baseTitleTextStyle =
    baseTextStyle.copyWith(fontWeight: FontWeight.w700);
    _textStyleBold32 = baseTitleTextStyle.copyWith(fontSize: 32);
    _textStyleBold26 = baseTitleTextStyle.copyWith(fontSize: 26);
    _textStyleBold24 = baseTitleTextStyle.copyWith(fontSize: 24);
    _textStyleBold20 = baseTitleTextStyle.copyWith(fontSize: 20);
    _textStyleBold18 = baseTitleTextStyle.copyWith(fontSize: 18);
    _textStyleBold16 = baseTitleTextStyle.copyWith(fontSize: 16);
    _textStyleBold14 = baseTitleTextStyle.copyWith(fontSize: 14);
    _textStyleBold12 = baseTitleTextStyle.copyWith(fontSize: 12);

    _textStyleMed32 = baseTextStyle.copyWith(fontSize: 32);
    _textStyleMed26 = baseTextStyle.copyWith(fontSize: 26);
    _textStyleMed24 = baseTextStyle.copyWith(fontSize: 24);
    _textStyleMed20 = baseTextStyle.copyWith(fontSize: 20);
    _textStyleMed18 = baseTextStyle.copyWith(fontSize: 18);
    _textStyleMed16 = baseTextStyle.copyWith(fontSize: 16);
    _textStyleMed14 = baseTextStyle.copyWith(fontSize: 14);
    _textStyleMed12 = baseTextStyle.copyWith(fontSize: 12);
    _textStyleMed10 = baseTextStyle.copyWith(fontSize: 10);
  }

  TextStyle get textStyleBold32 => _textStyleBold32;
  TextStyle get textStyleBold26 => _textStyleBold26;
  TextStyle get textStyleBold24 => _textStyleBold24;
  TextStyle get textStyleBold20 => _textStyleBold20;
  TextStyle get textStyleBold18 => _textStyleBold18;
  TextStyle get textStyleBold16 => _textStyleBold16;
  TextStyle get textStyleBold14 => _textStyleBold14;
  TextStyle get textStyleBold12 => _textStyleBold12;

  TextStyle get textStyleMed32 => _textStyleMed32;
  TextStyle get textStyleMed26 => _textStyleMed26;
  TextStyle get textStyleMed24 => _textStyleMed24;
  TextStyle get textStyleMed20 => _textStyleMed20;
  TextStyle get textStyleMed18 => _textStyleMed18;
  TextStyle get textStyleMed16 => _textStyleMed16;
  TextStyle get textStyleMed14 => _textStyleMed14;
  TextStyle get textStyleMed12 => _textStyleMed12;
  TextStyle get textStyleMed10 => _textStyleMed10;
}