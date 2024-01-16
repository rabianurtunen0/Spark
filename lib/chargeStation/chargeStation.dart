import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:spark_app/chargeStation/homePage.dart';
import 'package:spark_app/chargeStation/profilePage.dart';

class ChargeStation extends StatefulWidget {
  const ChargeStation({super.key});

  @override
  State<ChargeStation> createState() => _ChargeStationState();
}

class _ChargeStationState extends State<ChargeStation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedItemPosition = 0;
  late final pageController = PageController(initialPage: selectedItemPosition);
  List<Widget> bottomBarPages = [
    const HomePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          bottomBarPages.length,
          (index) {
            return bottomBarPages[index];
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              Get.back();
            });
          },
          child: Icon(
            BootstrapIcons.columns_gap,
            size: ScreenUtil().setSp(18),
          ),
        ),
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.indicator,
        backgroundColor: Theme.of(context).cardColor,
        snakeViewColor: Theme.of(context).primaryColor,
        currentIndex: selectedItemPosition,
        onTap: (value) {
          setState(() {
            selectedItemPosition = value;
            pageController.jumpToPage(value);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              BootstrapIcons.house_fill,
              color: Theme.of(context).disabledColor,
            ),
            activeIcon: Icon(
              BootstrapIcons.house_fill,
              color: Theme.of(context).primaryColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              BootstrapIcons.person_fill,
              color: Theme.of(context).disabledColor,
            ),
            activeIcon: Icon(
              BootstrapIcons.person_fill,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
