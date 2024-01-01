import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class RentalHistoryPage extends StatefulWidget {
  const RentalHistoryPage({super.key});

  @override
  State<RentalHistoryPage> createState() => _RentalHistoryPageState();
}

class _RentalHistoryPageState extends State<RentalHistoryPage> {
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
        title: Text('Rental History',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(14),
                letterSpacing: 1.0)),
      ),
      
      body: Center(
        child: Text(
          'Rental History',
          style: TextStyle(
      color: Color(0XFF515856), 
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
      letterSpacing: 1.0,
    ),
        ),
      ),
    );
  }
}