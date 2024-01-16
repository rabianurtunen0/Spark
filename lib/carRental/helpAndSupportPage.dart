import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class HelpAndSupportPage extends StatefulWidget {
  const HelpAndSupportPage({super.key});

  @override
  State<HelpAndSupportPage> createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: Container(
          alignment: Alignment.centerLeft,
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.035),
          child: IconButton(
            onPressed: () {
              setState(() {
                Get.back();
              });
            },
            icon: Icon(
              Icons.arrow_back,
              size: ScreenUtil().setSp(17),
              color: Colors.white,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ),
        title: Text('Help & Support',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(14),
                letterSpacing: 1.0)),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.16),
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.02,
              0.0, MediaQuery.of(context).size.width * 0.02, 0.0),
          width: MediaQuery.of(context).size.width * 0.86,
          height: MediaQuery.of(context).size.height * 0.40,
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
                              right: MediaQuery.of(context).size.width * 0.02),
                          child: Icon(
                            BootstrapIcons.info_circle,
                            color: const Color(0XFF2D4153),
                            size: ScreenUtil().setSp(18),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02),
                          child: Text(
                            'About Us',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(12.5),
                              color: const Color(0XFF131C24).withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      BootstrapIcons.chevron_right,
                      color: const Color(0XFF2D4153),
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
                              right: MediaQuery.of(context).size.width * 0.02),
                          child: Icon(
                            BootstrapIcons.question_circle,
                            color: const Color(0XFF2D4153),
                            size: ScreenUtil().setSp(18),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02),
                          child: Text(
                            'How Do Use?',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(12.5),
                              color: const Color(0XFF131C24).withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      BootstrapIcons.chevron_right,
                      color: const Color(0XFF2D4153),
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
                              right: MediaQuery.of(context).size.width * 0.02),
                          child: Icon(
                            BootstrapIcons.wechat,
                            color: const Color(0XFF2D4153),
                            size: ScreenUtil().setSp(18),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02),
                          child: Text(
                            'Frequently Asked Questions',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(12.5),
                              color: const Color(0XFF131C24).withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      BootstrapIcons.chevron_right,
                      color: const Color(0XFF2D4153),
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
                              right: MediaQuery.of(context).size.width * 0.02),
                          child: Icon(
                            BootstrapIcons.headset,
                            color: const Color(0XFF2D4153),
                            size: ScreenUtil().setSp(18),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02),
                          child: Text(
                            'Live Support',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(12.5),
                              color: const Color(0XFF131C24).withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      BootstrapIcons.chevron_right,
                      color: const Color(0XFF2D4153),
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
                              right: MediaQuery.of(context).size.width * 0.025),
                          child: SvgPicture.asset(
                            'assets/images/mail_phone.svg',
                            color: const Color(0XFF2D4153),
                            width: ScreenUtil().setSp(18),
                            height: ScreenUtil().setSp(18),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02),
                          child: Text(
                            'Contact Us',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(12.5),
                              color: const Color(0XFF131C24).withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      BootstrapIcons.chevron_right,
                      color: const Color(0XFF2D4153),
                      size: ScreenUtil().setSp(15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
