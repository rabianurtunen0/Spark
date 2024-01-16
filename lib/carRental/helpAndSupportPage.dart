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
  List list = [
    'Hakkımızda',
    'Nasıl Kullanırım?',
    'Sıkça Sorulan Sorular',
    'Canlı Destek',
    'Bize Ulaş'
  ];

  List listIcons = [
    BootstrapIcons.info_circle,
    BootstrapIcons.question_circle,
    BootstrapIcons.wechat,
    BootstrapIcons.headset,
    ''
  ];

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
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.16),
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
                          child: const Icon(
                            BootstrapIcons.info_circle,
                            color: Color(0XFF2D4153),
                            size: 24,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02),
                          child: const Text(
                            'About Us',
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
                              right: MediaQuery.of(context).size.width * 0.02),
                          child: const Icon(
                            BootstrapIcons.question_circle,
                            color: Color(0XFF2D4153),
                            size: 24,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02),
                          child: const Text(
                            'How Do Use?',
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
                              right: MediaQuery.of(context).size.width * 0.02),
                          child: const Icon(
                            BootstrapIcons.wechat,
                            color: Color(0XFF2D4153),
                            size: 24,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02),
                          child: const Text(
                            'Frequently Asked Questions',
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
                              right: MediaQuery.of(context).size.width * 0.02),
                          child: const Icon(
                            BootstrapIcons.headset,
                            color: Color(0XFF2D4153),
                            size: 24,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02),
                          child: const Text(
                            'Live Support',
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
                              right: MediaQuery.of(context).size.width * 0.025),
                          child: SvgPicture.asset(
                            'assets/images/mail_phone.svg',
                            width: 22,
                            height: 22,
                            color: const Color(0XFF2D4153),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02),
                          child: const Text(
                            'Contact Us',
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
      ),

/*
        child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Theme.of(context).disabledColor,
                          width: 0.5,
                        ))),
                        child: MaterialButton(
                          elevation: 0,
                          highlightElevation: 0,
                          onPressed: () {},
                          color: Theme.of(context).scaffoldBackgroundColor,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  index == 4 
                                  ? Container(
                                    margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
                                    child: SvgPicture.asset(
                                      'assets/images/mail-and-phone.svg',
                                      width: 24,
                                      height: 24,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                  : Container(
                                    margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
                                    child: Icon(
                                      listIcons[index],
                                      size: 20,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                    child: Text(
                                      list[index],
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                BootstrapIcons.chevron_right,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
      */
    );
  }
}
