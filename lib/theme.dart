import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeStyles {
  final textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      foregroundColor:
          MaterialStateProperty.all<Color>(const Color(0XFF2D4153)),
      overlayColor:
          MaterialStateColor.resolveWith((states) => Colors.transparent),
      elevation: MaterialStateProperty.all<double?>(0.0),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: ScreenUtil().setSp(10),
          letterSpacing: 1.0,
        ),
      ),
    ),
  );

  final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0XFF5982A6)),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      overlayColor: MaterialStateProperty.resolveWith(
          (states) => const Color(0XFF53799A)),
      elevation: MaterialStateProperty.all<double?>(0.0),
      side: MaterialStateProperty.all(
        const BorderSide(
          color: Color(0XFF5982A6),
          width: 1.0,
        ),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: ScreenUtil().setSp(13),
          letterSpacing: 1.5,
        ),
      ),
    ),
  );

  final outlinedButtonTheme = OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0XFFEBEFEE)),
      foregroundColor:
          MaterialStateProperty.all<Color>(const Color(0XFF131C24)),
      overlayColor: MaterialStateProperty.resolveWith(
          (states) => const Color(0XFFDDE4E2)),
      elevation: MaterialStateProperty.all<double?>(0.0),
      side: MaterialStateProperty.all(
        const BorderSide(
          color: Color(0XFFEBEFEE),
          width: 1.0,
        ),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: ScreenUtil().setSp(13),
          letterSpacing: 1.5,
        ),
      ),
    ),
  );

  final floatingActionButton = const FloatingActionButtonThemeData(
    backgroundColor: Color(0XFF5982A6),
    splashColor: Color(0XFF53799A),
    hoverColor: Color(0XFF53799A),
    foregroundColor: Color(0XFFF1F4F3),
    focusColor: Colors.white,
    elevation: 2.0,
    highlightElevation: 4.0,
  );

  final sliderTheme = SliderThemeData(
    inactiveTrackColor: const Color(0XFF98999A),
    activeTrackColor: const Color(0XFF5982A6),
    thumbColor: const Color(0XFF5982A6),
    overlayColor: const Color(0XFFACC1D2),
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
    trackHeight: 2,
    valueIndicatorColor:const Color(0XFF89A6BF),
    showValueIndicator: ShowValueIndicator.always,
    valueIndicatorTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: ScreenUtil().setSp(10)
    ),

  );
}
