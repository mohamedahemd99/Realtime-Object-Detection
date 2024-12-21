import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color blue = Color(0xff2BAEE0);
  static const Color grey = Colors.grey;
}

class AppFonts {
  AppFonts._();

  static const String fontRoboto = 'Roboto';
}

class AppFontSizes {
  AppFontSizes._();

  static const double extraExtraSmall = 10.0;
  static const double extraSmall = 12.0;
  static const double small = 14.0;
  static const double medium = 16.0;
  static const double large = 18.0;
}

class AppTextStyles {
  AppTextStyles._();

  //Regular
  static TextStyle regularTextStyle(
          {double? fontSize,
          Color? color,
          double? height,
          Color? backgroundColor}) =>
      TextStyle(
          fontFamily: AppFonts.fontRoboto,
          fontWeight: FontWeight.w300,
          fontSize: fontSize ?? AppFontSizes.medium,
          color: color ?? AppColors.black,
          backgroundColor: backgroundColor,
          height: height);

  //Medium
  static TextStyle mediumTextStyle(
          {double? fontSize,
          Color? color,
          double? height,
          Color? backgroundColor}) =>
      TextStyle(
          fontFamily: AppFonts.fontRoboto,
          fontSize: fontSize ?? AppFontSizes.medium,
          fontWeight: FontWeight.w500,
          color: color ?? AppColors.black,
          backgroundColor: backgroundColor,
          height: height);

  //Bold
  static TextStyle boldTextStyle(
          {double? fontSize,
          Color? color,
          double? height,
          Color? backgroundColor}) =>
      TextStyle(
          fontFamily: AppFonts.fontRoboto,
          fontSize: fontSize ?? AppFontSizes.medium,
          fontWeight: FontWeight.w700,
          color: color ?? AppColors.black,
          backgroundColor: backgroundColor,
          height: height);
}

class AppStrings {
  AppStrings._();

  static const title = 'Realtime Object Detection';
}
