import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:spark_app/secondPage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.08,
                MediaQuery.of(context).size.height * 0.24,
                MediaQuery.of(context).size.width * 0.08,
                MediaQuery.of(context).size.height * 0.16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.02),
                        width: MediaQuery.of(context).size.width * 0.185,
                        height: MediaQuery.of(context).size.width * 0.185,
                        child: SvgPicture.asset('assets/images/spark_app_logo.svg',
                            color: const Color(0XFF131C24)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Text(
                          "The Full Force of Spark",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(50),
                              letterSpacing: 1.5),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.01,
                            MediaQuery.of(context).size.height * 0.03,
                            MediaQuery.of(context).size.width * 0.01,
                            0.0),
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Text(
                          "Discover Spark for next generation Charging, Station and Rental Vehicle solutions",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: const Color(0XFF39546B),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(11.6),
                              letterSpacing: 0.4,
                              height: 1.5),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.14,
                      height: MediaQuery.of(context).size.width * 0.14,
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            Get.to(const SecondPage(),
                                duration: const Duration(milliseconds: 400),
                                transition: Transition.fadeIn);
                          });
                        },
                        color: const Color(0XFFD0E5E1).withOpacity(0.4),
                        shape: const CircleBorder(),
                        elevation: 0.0,
                        highlightElevation: 0.0,
                        highlightColor: const Color(0XFFD0E5E1).withOpacity(0.2),
                        splashColor: const Color(0XFFD0E5E1).withOpacity(0.2),
                        child: Icon(BootstrapIcons.arrow_right,
                            color: Colors.white, size: ScreenUtil().setSp(16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ),

    );
  }
}
