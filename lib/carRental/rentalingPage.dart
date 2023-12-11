import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';

class RentalingPage extends StatefulWidget {
  const RentalingPage({super.key});

  @override
  State<RentalingPage> createState() => _RentalingPageState();
}

class _RentalingPageState extends State<RentalingPage> {
  final _scrollController = ScrollController();
  final _scrollController2 = ScrollController();

  List packageList = [
    ['1 hour 30 km', '10.2'],
    ['2 hours 30 km', '15.3'],
    ['2 hours 50 km', '20.4'],
    ['1 day', '24.0'],
    ['3 hours 30 km', '25.5'],
    ['3 hours 60 km', '30.6'],
    ['5 hours 80 km', '35.6'],
    ['8 hours 100 km', '38.0'],
    ['1 day 100 km', '39.0'],
    ['1 day 175 km', '45.0'],
    ['1 day 250 km', '51.0'],
    ['2 days 400 km', '78.0'],
    ['3 days 600 km', '117.0'],
    ['5 days 500 km', '195.0'],
    ['7 days 800 km', '273.0'],
    ['7 days 1400 km', '357.0'],
    ['14 days 1500 km', '546.0'],
    ['14 days 2800 km', '714.0']
  ];

  bool showPackage = false;

  final date = DateFormat('dd/MM/yyyy').format(DateTime.now());
  DateTime nowTime = DateTime.now();
  DateTime time1 = DateTime.now();
  DateTime time2 = DateTime.now().add(const Duration(days: 1));
  bool startTimeBar = false;
  bool endTimeBar = false;
  int hourlyAndDailyPackageButtonNumber = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    0.0,
                    MediaQuery.of(context).size.height * 0.15,
                    0.0,
                    MediaQuery.of(context).size.height * 0.05),
                child: SvgPicture.asset('assets/images/mazda_car.svg',
                    width: MediaQuery.of(context).size.width * 0.5),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01),
                width: MediaQuery.of(context).size.width * 0.86,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.04,
                                  MediaQuery.of(context).size.height * 0.02,
                                  MediaQuery.of(context).size.width * 0.04,
                                  MediaQuery.of(context).size.height * 0.004),
                              child: Text('Mazda CX-5',
                                  style: TextStyle(
                                    color: const Color(0XFF131C24),
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(13),
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.04,
                                  0.0,
                                  MediaQuery.of(context).size.width * 0.04,
                                  MediaQuery.of(context).size.height * 0.012),
                              child: Text('CX-5 2.0 Power Sense 100. Year',
                                  style: TextStyle(
                                    color: Theme.of(context).disabledColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(11),
                                  )),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0.0,
                              0.0,
                              MediaQuery.of(context).size.width * 0.03,
                              MediaQuery.of(context).size.height * 0.01),
                          width: MediaQuery.of(context).size.width * 0.24,
                          height: MediaQuery.of(context).size.height * 0.028,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Center(
                            child: Text('46 m',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(10),
                                )),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.06,
                          0.0,
                          MediaQuery.of(context).size.width * 0.06,
                          MediaQuery.of(context).size.height * 0.012),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0.0,
                                      MediaQuery.of(context).size.height * 0.01,
                                      0.0,
                                      0.0),
                                  child: Icon(
                                    BootstrapIcons.person_walking,
                                    color: const Color(0XFF131C24),
                                    size: ScreenUtil().setSp(10),
                                  )),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0.0,
                                    MediaQuery.of(context).size.height * 0.01,
                                    0.0,
                                    MediaQuery.of(context).size.height * 0.01),
                                child: Text(
                                  '60+min',
                                  style: TextStyle(
                                    color: const Color(0XFF131C24),
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.04,
                                    MediaQuery.of(context).size.height * 0.01,
                                    0.0,
                                    0.0),
                                child: SvgPicture.asset(
                                  'assets/images/gear_stick.svg',
                                  //color: const Color(0XFF131C24),
                                  width:
                                      MediaQuery.of(context).size.width * 0.028,
                                  height:
                                      MediaQuery.of(context).size.width * 0.028,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.04,
                                    MediaQuery.of(context).size.height * 0.01,
                                    0.0,
                                    MediaQuery.of(context).size.height * 0.01),
                                child: Text(
                                  'Automatic',
                                  style: TextStyle(
                                    color: const Color(0XFF131C24),
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.04,
                                      MediaQuery.of(context).size.height * 0.01,
                                      0.0,
                                      0.0),
                                  child: Icon(
                                    BootstrapIcons.fuel_pump,
                                    color: const Color(0XFF131C24),
                                    size: ScreenUtil().setSp(10),
                                  )),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.04,
                                    MediaQuery.of(context).size.height * 0.01,
                                    0.0,
                                    MediaQuery.of(context).size.height * 0.01),
                                child: Text(
                                  '88%',
                                  style: TextStyle(
                                    color: const Color(0XFF131C24),
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.04,
                                      MediaQuery.of(context).size.height * 0.01,
                                      0.0,
                                      0.0),
                                  child: Icon(
                                    BootstrapIcons.bag_fill,
                                    color: const Color(0XFF131C24),
                                    size: ScreenUtil().setSp(10),
                                  )),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.04,
                                    MediaQuery.of(context).size.height * 0.01,
                                    0.0,
                                    MediaQuery.of(context).size.height * 0.01),
                                child: Text(
                                  'Insured',
                                  style: TextStyle(
                                    color: const Color(0XFF131C24),
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.04,
                          0.0,
                          MediaQuery.of(context).size.width * 0.04,
                          MediaQuery.of(context).size.height * 0.008),
                      child: Row(
                        children: [
                          Text(
                            '0.17' + ' €',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(17),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.02),
                            child: Text(
                              '/ minute',
                              style: TextStyle(
                                color: Theme.of(context).disabledColor,
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(10),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.04,
                          0.0,
                          MediaQuery.of(context).size.width * 0.04,
                          MediaQuery.of(context).size.height * 0.008),
                      child: Row(
                        children: [
                          Text(
                            '51' + ' €',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(17),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.02),
                            child: Text(
                              '/ daily',
                              style: TextStyle(
                                color: Theme.of(context).disabledColor,
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(10),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0.0,
                          MediaQuery.of(context).size.height * 0.01,
                          0.0,
                          MediaQuery.of(context).size.height * 0.005),
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.04,
                          0.0,
                          MediaQuery.of(context).size.width * 0.04,
                          0.0),
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: const BoxDecoration(
                          border: Border.symmetric(
                              horizontal: BorderSide(
                        color: Color(0XFF131C24),
                        width: 0.2,
                      ))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Insurance',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).disabledColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: ScreenUtil().setSp(10))),
                                  Text(
                                    'Free',
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontWeight: FontWeight.w700,
                                        fontSize: ScreenUtil().setSp(10)),
                                  ),
                                ]),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('250 km in use',
                                    style: TextStyle(
                                        color: Theme.of(context).disabledColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(10))),
                                Text(
                                  'Free',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontWeight: FontWeight.w700,
                                      fontSize: ScreenUtil().setSp(10)),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Additional km fee',
                                    style: TextStyle(
                                        color: Theme.of(context).disabledColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(10))),
                                Text(
                                  '0.12' + ' €',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontWeight: FontWeight.w700,
                                      fontSize: ScreenUtil().setSp(10)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03),
                width: MediaQuery.of(context).size.width * 0.86,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/marker_icon.svg',
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.03),
                        child: Text(
                          'Bedir Mahallesi Ataseven Caddesi No:1 Selçuklu/KONYA',
                          style: TextStyle(
                            //color: Theme.of(context).primaryColorDark,
                            color: const Color(0XFF131C24),
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(11),
                          ),
                          maxLines: 3,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01),
                width: MediaQuery.of(context).size.width * 0.86,
                height: MediaQuery.of(context).size.height * 0.32,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02,
                          horizontal: MediaQuery.of(context).size.width * 0.04),
                      child: Text(
                        'Hourly/Daily Packages',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(11)),
                      ),
                    ),
                    SingleChildScrollView(
                      controller: _scrollController2,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.248,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: packageList.length,
                          itemBuilder: (context, index1) {
                            return Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.04,
                                    MediaQuery.of(context).size.height * 0.004,
                                    MediaQuery.of(context).size.width * 0.04,
                                    MediaQuery.of(context).size.height * 0.004),
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: index1 ==
                                            hourlyAndDailyPackageButtonNumber
                                        ? Border.all(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                          )
                                        : const Border()),
                                child: MaterialButton(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onPressed: () {
                                    setState(() {
                                      hourlyAndDailyPackageButtonNumber =
                                          index1;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            packageList[index1][0],
                                            style: TextStyle(
                                                color: const Color(0XFF131C24),
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    ScreenUtil().setSp(11)),
                                          ),
                                          Text(
                                              packageList[index1][0] == "1 day"
                                                  ? "Her km başına: "
                                                      '0.12'
                                                      " €"
                                                  : "Ekstra her km başına: "
                                                      '0.12'
                                                      " €",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .disabledColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    ScreenUtil().setSp(10),
                                              ))
                                        ],
                                      ),
                                      Text(
                                        packageList[index1][1] + ' €',
                                        style: TextStyle(
                                            color: const Color(0XFF131C24),
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(11)),
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01),
                width: MediaQuery.of(context).size.width * 0.86,
                height: startTimeBar
                    ? MediaQuery.of(context).size.height * 0.33
                    : endTimeBar
                        ? MediaQuery.of(context).size.height * 0.33
                        : MediaQuery.of(context).size.height * 0.18,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.76,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).disabledColor,
                            width: 0.3,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.016,
                                MediaQuery.of(context).size.height * 0.008,
                                0.0,
                                0.0),
                            child: Text(
                              'Start time',
                              style: TextStyle(
                                color: const Color(0XFF131C24),
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(12),
                              ),
                            ),
                          ),
                          Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.fromLTRB(
                                  0.0,
                                  MediaQuery.of(context).size.height * 0.008,
                                  0.0,
                                  0.0),
                              child: Material(
                                elevation: 0,
                                color: Colors.transparent,
                                child: MaterialButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Text(
                                        DateFormat('dd/MM/yyyy hh:mm a')
                                            .format(time1)
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(11),
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.018),
                                        child: Icon(
                                          startTimeBar
                                              ? BootstrapIcons.chevron_up
                                              : BootstrapIcons.chevron_down,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          size: ScreenUtil().setSp(14),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      startTimeBar = !startTimeBar;
                                      endTimeBar = false;
                                    });
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                    startTimeBar
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.76,
                            height: MediaQuery.of(context).size.height * 0.154,
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                color: Theme.of(context).disabledColor,
                                width: 0.3,
                              )),
                            ),
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                CupertinoTheme(
                                  data: CupertinoThemeData(
                                      textTheme: CupertinoTextThemeData(
                                          dateTimePickerTextStyle: TextStyle(
                                    color: const Color(0XFF131C24),
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(12),
                                  ))),
                                  child: CupertinoDatePicker(
                                    initialDateTime: time1,
                                    onDateTimeChanged: (DateTime newDateTime) {
                                      setState(() {
                                        time1 = newDateTime;
                                      });
                                    },
                                    use24hFormat: false,
                                    minimumDate: nowTime,
                                    minuteInterval: 1,
                                    mode: CupertinoDatePickerMode.dateAndTime,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.044,
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.022),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.fromBorderSide(
                                            BorderSide(
                                                width: 1,
                                                color: Theme.of(context)
                                                    .primaryColorLight)),
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.76,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).disabledColor,
                            width: 0.3,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.016,
                                MediaQuery.of(context).size.height * 0.008,
                                0.0,
                                0.0),
                            child: Text(
                              'End time',
                              style: TextStyle(
                                color: const Color(0XFF131C24),
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(12),
                              ),
                            ),
                          ),
                          Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.fromLTRB(
                                  0.0,
                                  MediaQuery.of(context).size.height * 0.008,
                                  0.0,
                                  0.0),
                              child: Material(
                                elevation: 0,
                                color: Colors.transparent,
                                child: MaterialButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Text(
                                        DateFormat('dd/MM/yyyy hh:mm a')
                                            .format(time2)
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(11),
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.018),
                                        child: Icon(
                                          endTimeBar
                                              ? BootstrapIcons.chevron_up
                                              : BootstrapIcons.chevron_down,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          size: ScreenUtil().setSp(14),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      endTimeBar = !endTimeBar;
                                      startTimeBar = false;
                                    });
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                    endTimeBar
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.76,
                            height: MediaQuery.of(context).size.height * 0.154,
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                color: Theme.of(context).disabledColor,
                                width: 0.3,
                              )),
                            ),
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                CupertinoTheme(
                                  data: CupertinoThemeData(
                                      textTheme: CupertinoTextThemeData(
                                          dateTimePickerTextStyle: TextStyle(
                                    color: const Color(0XFF131C24),
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(12),
                                  ))),
                                  child: CupertinoDatePicker(
                                    initialDateTime: time2,
                                    onDateTimeChanged: (DateTime newDateTime) {
                                      setState(() {
                                        time2 = newDateTime;
                                      });
                                    },
                                    use24hFormat: false,
                                    minimumDate: nowTime,
                                    minuteInterval: 1,
                                    mode: CupertinoDatePickerMode.dateAndTime,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.044,
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.022),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.fromBorderSide(
                                            BorderSide(
                                                width: 1,
                                                color: Theme.of(context)
                                                    .primaryColorLight)),
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.76,
                      height: MediaQuery.of(context).size.height * 0.048,
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.016,
                                MediaQuery.of(context).size.height * 0.008,
                                0.0,
                                0.0),
                            child: Text(
                              'Time period',
                              style: TextStyle(
                                color: const Color(0XFF131C24),
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.01),
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.07,
                    vertical: MediaQuery.of(context).size.height * 0.018,
                  ),
                  width: MediaQuery.of(context).size.width * 0.86,
                  height: MediaQuery.of(context).size.height * 0.28,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Rent price',
                            style: TextStyle(
                              color: const Color(0XFF131C24),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(12),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.04,
                              0.0,
                              MediaQuery.of(context).size.width * 0.04,
                              MediaQuery.of(context).size.height * 0.008),
                          child: Row(
                            children: [
                              Text(
                                '51' + ' €',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontWeight: FontWeight.w600,
                                  fontSize: ScreenUtil().setSp(17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.02),
                                child: Text(
                                  '/ 1 Day',
                                  style: TextStyle(
                                    color: Theme.of(context).disabledColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(10),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ])),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0.0, MediaQuery.of(context).size.height * 0.022, 0.0, 0.0),
                width: MediaQuery.of(context).size.width * 0.68,
                height: MediaQuery.of(context).size.height * 0.051,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text('Rent'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
