import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SpecialToMePage extends StatefulWidget {
  const SpecialToMePage({super.key});

  @override
  State<SpecialToMePage> createState() => _SpecialToMePageState();
}

class _SpecialToMePageState extends State<SpecialToMePage> {
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
        title: Text('Special to Me',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(14),
                letterSpacing: 1.0)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.18),
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.02,
                    0.0,
                    MediaQuery.of(context).size.width * 0.02,
                    0.0),
                width: MediaQuery.of(context).size.width * 0.86,
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0.0,
                          0.0,
                          MediaQuery.of(context).size.width * 0.02,
                          MediaQuery.of(context).size.height * 0.01),
                      child: SvgPicture.asset(
                        'assets/images/opet-logo.svg',
                        width: 64,
                        height: 19.94,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.56,
                      child: RichText(
                        text: TextSpan(
                          text:
                              "By scanning the QR code on the page showing the rented vehicle, you can get your fuel for free from ",
                          style: TextStyle(
                            color: Color(0XFF131C24),
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(12),
                          ),
                          children: [
                            TextSpan(
                              text: "Opet fuel stations",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenUtil().setSp(12),
                              ),
                            ),
                            TextSpan(
                              text: ".",
                              style: TextStyle(
                                color: Color(0XFF131C24),
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03),
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.02,
                    0.0,
                    MediaQuery.of(context).size.width * 0.02,
                    0.0),
                width: MediaQuery.of(context).size.width * 0.86,
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.04,
                            0.0,
                            0.0,
                            0.0),
                        child: SvgPicture.asset(
                          'assets/images/discount_text.svg',
                          width: MediaQuery.of(context).size.width * 0.18,
                          height: MediaQuery.of(context).size.width * 0.18,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0.0,
                          0.0,
                          MediaQuery.of(context).size.width * 0.02,
                          MediaQuery.of(context).size.height * 0.01),
                      child: SvgPicture.asset(
                        'assets/images/discount.svg',
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: MediaQuery.of(context).size.width * 0.18,
                      ),
                    )
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
