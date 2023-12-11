import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spark_app/carRental/helpAndSupportPage.dart';
import 'package:spark_app/carRental/notificationPage.dart';
import 'package:spark_app/carRental/privileges.dart';
import 'package:spark_app/carRental/serviceAreas.dart';
import 'package:spark_app/carRental/carsAndPricesPage.dart';
import 'package:spark_app/firstPage.dart';
import 'package:spark_app/signUpPage.dart';

class ProfilePage extends StatefulWidget {
  String fullName, email;

  ProfilePage({
    Key? key,
    required this.fullName,
    required this.email,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool containerHeight = false;
  bool containerButton = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0))
        .then((value) => setState(() {
              containerHeight = true;
            }));
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => setState(() {
              containerButton = true;
            }));
    if (mounted) {}
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.canvas,
      child: Stack(
        alignment: Alignment.topCenter,
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
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: widget.email == ""
                          ? MediaQuery.of(context).size.height * 0.11
                          : MediaQuery.of(context).size.height * 0.12),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.fullName,
                        style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      widget.email == ""
                          ? Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.01),
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.width * 0.09,
                              child: MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    Get.to(const SignUpPage());
                                  });
                                },
                                color: const Color(0XFFD0E5E1).withOpacity(0.4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                elevation: 0.0,
                                highlightElevation: 0.0,
                                highlightColor:
                                    const Color(0XFFD0E5E1).withOpacity(0.2),
                                splashColor:
                                    const Color(0XFFD0E5E1).withOpacity(0.2),
                                child: Text(
                                  'Üye olunuz',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenUtil().setSp(11),
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            )
                          : Text(
                              widget.email,
                              style: const TextStyle(
                                color: Color(0XFFC4C8CD),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.07),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        Get.to(const NotificationPage());
                      });
                    },
                    icon: const Icon(
                      Icons.notifications,
                      color: Color(0XFF131C24),
                    ),
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.22),
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.02,
                    0.0,
                    MediaQuery.of(context).size.width * 0.02,
                    0.0),
                width: MediaQuery.of(context).size.width * 0.86,
                height: containerHeight
                    ? MediaQuery.of(context).size.height * 0.48
                    : 0.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Column(
                  children: [
                    MaterialButton(
                      elevation: 0,
                      height: MediaQuery.of(context).size.height * 0.08,
                      highlightElevation: 0,
                      onPressed: () {
                        setState(() {});
                      },
                      color: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.02),
                                child: const Icon(
                                  BootstrapIcons.person_fill,
                                  color: Color(0XFF2D4153),
                                  size: 24,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02),
                                child: const Text(
                                  'My Account',
                                  style: TextStyle(
                                    color: Color(0XFF2D4153),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            BootstrapIcons.chevron_right,
                            color: Color(0XFF2D4153),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      elevation: 0,
                      height: MediaQuery.of(context).size.height * 0.08,
                      highlightElevation: 0,
                      onPressed: () {
                        setState(() {});
                      },
                      color: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.02),
                                child: const Icon(
                                  Icons.history,
                                  color: Color(0XFF2D4153),
                                  size: 24,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02),
                                child: const Text(
                                  'Rental History',
                                  style: TextStyle(
                                    color: Color(0XFF2D4153),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            BootstrapIcons.chevron_right,
                            color: Color(0XFF2D4153),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      elevation: 0,
                      height: MediaQuery.of(context).size.height * 0.08,
                      highlightElevation: 0,
                      onPressed: () {
                        setState(() {
                          Get.to(const CarsAndPricesPage());
                        });
                      },
                      color: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.02),
                                child: const Icon(
                                  BootstrapIcons.car_front,
                                  color: Color(0XFF2D4153),
                                  size: 24,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02),
                                child: const Text(
                                  'Cars and Prices',
                                  style: TextStyle(
                                    color: Color(0XFF2D4153),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            BootstrapIcons.chevron_right,
                            color: Color(0XFF2D4153),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      elevation: 0,
                      height: MediaQuery.of(context).size.height * 0.08,
                      highlightElevation: 0,
                      onPressed: () {
                        setState(() {
                          Get.to(const ServiceAreasPage());
                        });
                      },
                      color: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.02),
                                child: const Icon(
                                  Icons.map_outlined,
                                  color: Color(0XFF2D4153),
                                  size: 24,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02),
                                child: const Text(
                                  'Service Area',
                                  style: TextStyle(
                                    color: Color(0XFF2D4153),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            BootstrapIcons.chevron_right,
                            color: Color(0XFF2D4153),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      elevation: 0,
                      height: MediaQuery.of(context).size.height * 0.08,
                      highlightElevation: 0,
                      onPressed: () {
                        setState(() {
                          Get.to(const PrivilegesPage());
                        });
                      },
                      color: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.02),
                                child: const Icon(
                                  Icons.star,
                                  color: Color(0XFF2D4153),
                                  size: 24,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02),
                                child: const Text(
                                  'Privileges',
                                  style: TextStyle(
                                    color: Color(0XFF2D4153),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            BootstrapIcons.chevron_right,
                            color: Color(0XFF2D4153),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      elevation: 0,
                      height: MediaQuery.of(context).size.height * 0.08,
                      highlightElevation: 0,
                      onPressed: () {
                        setState(() {
                          Get.to(const HelpAndSupportPage());
                        });
                      },
                      color: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.02),
                                child: const Icon(
                                  BootstrapIcons.question,
                                  color: Color(0XFF2D4153),
                                  size: 24,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02),
                                child: const Text(
                                  'Help & Support',
                                  style: TextStyle(
                                    color: Color(0XFF2D4153),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            BootstrapIcons.chevron_right,
                            color: Color(0XFF2D4153),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03),
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.02,
                    0.0,
                    MediaQuery.of(context).size.width * 0.02,
                    0.0),
                width: MediaQuery.of(context).size.width * 0.86,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(16.0))),
                child: MaterialButton(
                  elevation: 0,
                  height: MediaQuery.of(context).size.height * 0.07,
                  highlightElevation: 0,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove("email");
                    await FirebaseAuth.instance.signOut();
                    Get.offAll(() => const FirstPage());
                  },
                  color: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * 0.02),
                            child: const Icon(
                              BootstrapIcons.box_arrow_right,
                              color: Color(0XFFA65969),
                              size: 24,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.02),
                            child: const Text(
                              'Log Out',
                              style: TextStyle(
                                color: Color(0XFFA65969),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        BootstrapIcons.chevron_right,
                        color: Color(0XFFA65969),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
