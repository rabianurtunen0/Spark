import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:spark_app/carRental/carRental.dart';
import 'package:spark_app/chargeStation/chargeStation.dart';
import 'package:spark_app/secondPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [ 
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.08),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.32,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment(0.0, 0.0),
                        image: AssetImage('assets/images/small_bg.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.zero, bottom: Radius.circular(24.0))),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.10,
                      MediaQuery.of(context).size.height * 0.16,
                      0.0,
                      0.0),
                    child: Text(
                      'Hello, Rabia Nur!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(16),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                    onTap: () {
                      setState(() {
                        Get.to(const ChargeStation());
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.05,
                          MediaQuery.of(context).size.height * 0.25,
                          MediaQuery.of(context).size.width * 0.05,
                          0.0
                          ),   
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width * 0.05
                              ),
                             height: MediaQuery.of(context).size.height * 0.18,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'SPARK',
                                    style: TextStyle(
                                      color: const Color(0XFF131C24),
                                      fontWeight: FontWeight.w800,
                                      fontSize: ScreenUtil().setSp(16),
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  Text(
                                    'charge',
                                    style: TextStyle(
                                      color: const Color(0XFF131C24),
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/images/chargeStation.svg',
                              width: MediaQuery.of(context).size.width * 0.32,
                              height: MediaQuery.of(context).size.height * 0.24
                            ),
                          ],
                        )),
                  ),
            ],
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.08),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.32,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment(0.0, 0.0),
                        image: AssetImage('assets/images/small_bg_vertical.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24.0), bottom: Radius.zero)),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.08),
                      width: MediaQuery.of(context).size.width * 0.14,
                      height: MediaQuery.of(context).size.width * 0.14,
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            Get.offAll(const SecondPage());
                          });
                        },
                        color: const Color(0XFFD0E5E1).withOpacity(0.4),
                        shape: const CircleBorder(),
                        elevation: 0.0,
                        highlightElevation: 0.0,
                        highlightColor: const Color(0XFFD0E5E1).withOpacity(0.2),
                        splashColor: const Color(0XFFD0E5E1).withOpacity(0.2),
                        child: Container(
                          margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                                BootstrapIcons.box_arrow_left,
                                  color: Colors.white, 
                                  size: ScreenUtil().setSp(20)
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              GestureDetector(
                    onTap: () {
                      setState(() {
                        Get.to(const CarRental());
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.05,
                          0.0,
                          MediaQuery.of(context).size.width * 0.05,
                          MediaQuery.of(context).size.height * 0.25
                          ), 
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width * 0.05
                              ),
                             height: MediaQuery.of(context).size.height * 0.18,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'SPARK',
                                    style: TextStyle(
                                      color: const Color(0XFF131C24),
                                      fontWeight: FontWeight.w800,
                                      fontSize: ScreenUtil().setSp(16),
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  Text(
                                    'rental',
                                    style: TextStyle(
                                      color: const Color(0XFF131C24),
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/images/carRental.svg',
                              width: MediaQuery.of(context).size.width * 0.32,
                              height: MediaQuery.of(context).size.height * 0.24
                            ),
                          ],
                        )),
                  ),
            ],
          )
        ],
      ),
    );
  }
}
