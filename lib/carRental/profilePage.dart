import 'dart:async';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spark_app/carRental/helpAndSupportPage.dart';
import 'package:spark_app/carRental/myAccountPage.dart';
import 'package:spark_app/carRental/specialToMePage.dart';
import 'package:spark_app/carRental/rentalHistoryPage.dart';
import 'package:spark_app/carRental/serviceArea.dart';
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
  BuildContext? _alertDialog;

  String fullNameText = "";
  String emailText = "";
  List cardsList = [];
  bool showEmail = true;

   void getInformations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    print(email);
    if (email == null) {
      fullNameText = "Guest User";
      emailText = "";
    } else {
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection('Users').doc(email).get();
      fullNameText = documentSnapshot.get('fullname');
      emailText = documentSnapshot.get('email');
      var collection = FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('Cards');
      var querySnapshot = await collection.get();
      var list = querySnapshot.docs;
      for (int i = 0; i < list.length; i++) {
        cardsList.add(list[i].data());
      }
      print('Cards List: $cardsList');
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getInformations();
    Timer(const Duration(milliseconds: 300 ), () {
      setState(() {

       widget.email == "" ? showEmail = false : showEmail = true;
      });
    });
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
            child: Container(
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
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  showEmail
                      ? Text(
                          widget.email,
                          style: const TextStyle(
                            color: Color(0XFFC4C8CD),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ) 
                        : Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01),
                          width: MediaQuery.of(context).size.width * 0.24,
                          height: MediaQuery.of(context).size.width * 0.08,
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
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenUtil().setSp(11),
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
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
                height: MediaQuery.of(context).size.height * 0.48,
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
                        setState(() {
                          widget.email == ""
                              ? showSignUp(context)
                              : Get.to(MyAccountPage(
                                  fullName: widget.fullName,
                                  email: widget.email,
                                  cardsList: cardsList,
                                ));
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
                                child: Icon(
                                  BootstrapIcons.person_fill,
                                  color: const Color(0XFF2D4153),
                                  size: ScreenUtil().setSp(19),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02),
                                child: Text(
                                  'My Account',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(13),
                                    color: const Color(0XFF131C24)
                                        .withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            BootstrapIcons.chevron_right,
                            color: Color(0XFF2D4153),
                            size: ScreenUtil().setSp(15),
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
                          widget.email == ""
                              ? showSignUp(context)
                              : Get.to(const RentalHistoryPage());
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
                                child: Icon(
                                  Icons.history,
                                  color: const Color(0XFF2D4153),
                                  size: ScreenUtil().setSp(19),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02),
                                child: Text(
                                  'Rental History',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(13),
                                    color: const Color(0XFF131C24)
                                        .withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            BootstrapIcons.chevron_right,
                            color: Color(0XFF2D4153),
                            size: ScreenUtil().setSp(15),
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
                                child: Icon(
                                  BootstrapIcons.car_front,
                                  color: const Color(0XFF2D4153),
                                  size: ScreenUtil().setSp(19),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02),
                                child: Text(
                                  'Cars and Prices',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(13),
                                    color: const Color(0XFF131C24)
                                        .withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            BootstrapIcons.chevron_right,
                            color: Color(0XFF2D4153),
                            size: ScreenUtil().setSp(15),
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
                          Get.to(const ServiceAreaPage());
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
                                child: Icon(
                                  Icons.map_outlined,
                                  color: const Color(0XFF2D4153),
                                  size: ScreenUtil().setSp(19),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02),
                                child: Text(
                                  'Service Area',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(13),
                                    color: const Color(0XFF131C24)
                                        .withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            BootstrapIcons.chevron_right,
                            color: Color(0XFF2D4153),
                            size: ScreenUtil().setSp(15),
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
                          Get.to(const SpecialToMePage());
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
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.01),
                                  child: Icon(
                                    BootstrapIcons.gift_fill,
                                    color: const Color(0XFF2D4153),
                                    size: ScreenUtil().setSp(15),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02),
                                child: Text(
                                  'Special to Me',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(13),
                                    color: const Color(0XFF131C24)
                                        .withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            BootstrapIcons.chevron_right,
                            color: Color(0XFF2D4153),
                            size: ScreenUtil().setSp(15),
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
                                child: Icon(
                                  BootstrapIcons.question,
                                  color: const Color(0XFF2D4153),
                                  size: ScreenUtil().setSp(20),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.02),
                                child: Text(
                                  'Help & Support',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(13),
                                    color: const Color(0XFF131C24)
                                        .withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            BootstrapIcons.chevron_right,
                            color: Color(0XFF2D4153),
                            size: ScreenUtil().setSp(15),
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
                            child: Icon(
                              BootstrapIcons.box_arrow_right,
                              color: const Color(0XFFA65969),
                              size: ScreenUtil().setSp(18),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.02),
                            child: Text(
                              'Log Out',
                              style: TextStyle(
                                color: const Color(0XFFA65969),
                                fontSize: ScreenUtil().setSp(13),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        BootstrapIcons.chevron_right,
                        color: const Color(0XFFA65969),
                        size: ScreenUtil().setSp(15),
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

  void showSignUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          _alertDialog = context;
          return AlertDialog(
            backgroundColor: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            titlePadding: EdgeInsets.zero,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02),
                  child: Icon(
                    BootstrapIcons.exclamation_circle_fill,
                    color: Theme.of(context).primaryColorDark,
                    size: ScreenUtil().setSp(42),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.12,
                      0.0,
                      MediaQuery.of(context).size.width * 0.12,
                      MediaQuery.of(context).size.height * 0.02),
                  child: Text(
                    'Please sign up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(13)),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
