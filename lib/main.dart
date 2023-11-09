import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:spark_app/firstPage.dart';
import 'package:spark_app/theme.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 640));
    return GetMaterialApp(
      title: 'Spark',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0XFF5982A6),
        highlightColor: const Color(0XFF53799A),
        cardColor: const Color(0XFFEFF0F1),
        hoverColor: const Color(0XFFE2E9E7),
        disabledColor: const Color(0XFF98999A),
        primaryColorDark: const Color(0XFFA65969),
        primaryColorLight: const Color(0XFF5BA697),
        textButtonTheme: ThemeStyles().textButtonTheme,
        elevatedButtonTheme: ThemeStyles().elevatedButtonTheme,
        outlinedButtonTheme: ThemeStyles().outlinedButtonTheme,
        floatingActionButtonTheme: ThemeStyles().floatingActionButton,
        sliderTheme: ThemeStyles().sliderTheme,
      ),
      home: const FirstPage(),
    );
  }
}
