import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:spark_app/carRental/hourlyAndDailyPackages.dart';

class CarsAndPricesPage extends StatefulWidget {
  const CarsAndPricesPage({super.key});

  @override
  State<CarsAndPricesPage> createState() => _CarsAndPricesPageState();
}

class _CarsAndPricesPageState extends State<CarsAndPricesPage> {
  final _scrollController = ScrollController();

  List carsList = [
    [
      'Suzuki XL7',
      'assets/images/suzuki_car.svg',
      'XL7 III 1.5i ',
      'Automatic',
      'Gasoline',
      '0.14',
      '42',
      '0.09',
    ],
    [
      'Toyota C-HR',
      'assets/images/toyota_car.svg',
      'C-HR 1.8 Hybrid Flame',
      'Automatic',
      'Hybrid',
      '0.15',
      '45',
      '0.10'
    ],
    [
      'Mazda CX-5',
      'assets/images/mazda_car.svg',
      'CX-5 2.0 Power Sense 100. Yıl',
      'Automatic',
      'Gasoline',
      '0.17',
      '51',
      '0.12'
    ],
    [
      'Pegout 208',
      'assets/images/peugeot_car.svg',
      '208 1.2 PureTech',
      'Automatic',
      'Gasoline',
      '0.15',
      '45',
      '0.10'
    ],
    [
      'Chevrolet Trailblazer',
      'assets/images/chevrolet_car.svg',
      'Trailblazer AWD',
      'Automatic',
      'Gasoline',
      '0.14',
      '42',
      '0.09'
    ]
  ];

  List packagesList = [
    [
      ['1 hour 30 km', '8.4'],
      ['2 hours 30 km', '12.6'],
      ['2 hours 50 km', '16.8'],
      ['1 day', '20.0'],
      ['3 hours 30 km', '21.2'],
      ['3 hours 60 km', '25.6'],
      ['5 hours 80 km', '28.0'],
      ['8 hours 100 km', '30.0'],
      ['1 day 100 km', '32.0'],
      ['1 day 175 km', '37.0'],
      ['1 day 250 km', '42.0'],
      ['2 days 400 km', '64.0'],
      ['3 days 600 km', '96.0'],
      ['5 days 500 km', '160.0'],
      ['7 days 800 km', '224.0'],
      ['7 days 1400 km', '294.0'],
      ['14 days 1500 km', '448.0'],
      ['14 days 2800 km', '588.0']
    ],
    [
      ['1 hour 30 km', '9.0'],
      ['2 hours 30 km', '13.5'],
      ['2 hours 50 km', '18.0'],
      ['1 day', '22.0'],
      ['3 hours 30 km', '22.5'],
      ['3 hours 60 km', '27.0'],
      ['5 hours 80 km', '31.0'],
      ['8 hours 100 km', '33.0'],
      ['1 day 100 km', '35.0'],
      ['1 day 175 km', '40.0'],
      ['1 day 250 km', '45.0'],
      ['2 days 400 km', '70.0'],
      ['3 days 600 km', '105.0'],
      ['5 days 500 km', '175.0'],
      ['7 days 800 km', '245.0'],
      ['7 days 1400 km', '315.0'],
      ['14 days 1500 km', '490.0'],
      ['14 days 2800 km', '630.0']
    ],
    [
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
    ],
    [
      ['1 hour 30 km', '9.0'],
      ['2 hours 30 km', '13.5'],
      ['2 hours 50 km', '18.0'],
      ['1 day', '22.0'],
      ['3 hours 30 km', '22.5'],
      ['3 hours 60 km', '27.0'],
      ['5 hours 80 km', '31.0'],
      ['8 hours 100 km', '33.0'],
      ['1 day 100 km', '35.0'],
      ['1 day 175 km', '40.0'],
      ['1 day 250 km', '45.0'],
      ['2 days 400 km', '70.0'],
      ['3 days 600 km', '105.0'],
      ['5 days 500 km', '175.0'],
      ['7 days 800 km', '245.0'],
      ['7 days 1400 km', '315.0'],
      ['14 days 1500 km', '490.0'],
      ['14 days 2800 km', '630.0']
    ],
    [
      ['1 hour 30 km', '8.4'],
      ['2 hours 30 km', '12.6'],
      ['2 hours 50 km', '16.8'],
      ['1 day', '20.0'],
      ['3 hours 30 km', '21.2'],
      ['3 hours 60 km', '25.6'],
      ['5 hours 80 km', '28.0'],
      ['8 hours 100 km', '30.0'],
      ['1 day 100 km', '32.0'],
      ['1 day 175 km', '37.0'],
      ['1 day 250 km', '42.0'],
      ['2 days 400 km', '64.0'],
      ['3 days 600 km', '96.0'],
      ['5 days 500 km', '160.0'],
      ['7 days 800 km', '224.0'],
      ['7 days 1400 km', '294.0'],
      ['14 days 1500 km', '448.0'],
      ['14 days 2800 km', '588.0']
    ],
  ];

  List packageList = [];

  String packageIcon = "";
  String package = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text('Cars and Prices',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(14),
                letterSpacing: 1.0)),
      ),
      body: ListView.builder(
          itemCount: carsList.length,
          itemBuilder: (context, index1) {
            return Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      index1 == 0
                          ? MediaQuery.of(context).size.height * 0.05
                          : MediaQuery.of(context).size.height * 0.025,
                      MediaQuery.of(context).size.width * 0.05,
                      index1 == carsList.length - 1
                          ? MediaQuery.of(context).size.height * 0.05
                          : MediaQuery.of(context).size.height * 0.025),
                  height: package == index1.toString()
                      ? MediaQuery.of(context).size.height * 0.58
                      : MediaQuery.of(context).size.height * 0.32,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.04,
                            MediaQuery.of(context).size.height * 0.02,
                            MediaQuery.of(context).size.width * 0.04,
                            MediaQuery.of(context).size.height * 0.004),
                        child: Text(carsList[index1][0],
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
                        child: Text(carsList[index1][2],
                            style: TextStyle(
                              color: Theme.of(context).disabledColor,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(11),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.035,
                            0.0,
                            MediaQuery.of(context).size.width * 0.035,
                            MediaQuery.of(context).size.height * 0.012),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.height * 0.01,
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.height *
                                          0.01),
                                  child: SvgPicture.asset(
                                    'assets/images/gear_stick.svg',
                                    //color: const Color(0XFF131C24),
                                    width: MediaQuery.of(context).size.width *
                                        0.028,
                                    height: MediaQuery.of(context).size.width *
                                        0.028,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.height * 0.01,
                                      MediaQuery.of(context).size.width * 0.025,
                                      MediaQuery.of(context).size.height *
                                          0.01),
                                  child: Text(
                                    carsList[index1][3],
                                    style: TextStyle(
                                      color: const Color(0XFF131C24),
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.025,
                                        MediaQuery.of(context).size.height *
                                            0.01,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        MediaQuery.of(context).size.height *
                                            0.01),
                                    child: Icon(
                                      BootstrapIcons.fuel_pump,
                                      color: const Color(0XFF131C24),
                                      size: ScreenUtil().setSp(10),
                                    )),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.height * 0.01,
                                      MediaQuery.of(context).size.width * 0.005,
                                      MediaQuery.of(context).size.height *
                                          0.01),
                                  child: Text(
                                    carsList[index1][4],
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
                              carsList[index1][5] + ' €',
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
                              carsList[index1][6] + ' €',
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
                                  vertical: MediaQuery.of(context).size.height *
                                      0.01),
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
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontWeight: FontWeight.w700,
                                          fontSize: ScreenUtil().setSp(10)),
                                    ),
                                  ]),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.01),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('250 km in use',
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
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.01),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Additional km fee',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).disabledColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: ScreenUtil().setSp(10))),
                                  Text(
                                    carsList[index1][7] + ' €',
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
                      Container(
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.004,
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                packageList = packagesList[index1];
                                package == index1.toString()
                                    ? package = ""
                                    : package = index1.toString();
                                packageIcon == index1.toString()
                                    ? packageIcon = ""
                                    : packageIcon = index1.toString();
                              });
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Hourly/Daily Packages',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontWeight: FontWeight.w600,
                                      fontSize: ScreenUtil().setSp(11)),
                                ),
                                IconButton(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.054),
                                  onPressed: () {
                                    setState(() {
                                      packageList = packagesList[index1];
                                      package == index1.toString()
                                          ? package = ""
                                          : package = index1.toString();
                                      packageIcon == index1.toString()
                                          ? packageIcon = ""
                                          : packageIcon = index1.toString();
                                    });
                                  },
                                  splashRadius: 1.0,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  icon: Icon(
                                    packageIcon == index1.toString()
                                        ? BootstrapIcons.chevron_up
                                        : BootstrapIcons.chevron_down,
                                    size: ScreenUtil().setSp(16),
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                )
                              ],
                            ),
                          )),
                      package == index1.toString()
                          ? SingleChildScrollView(
                              controller: _scrollController,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.248,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: packageList.length,
                                  itemBuilder: (context, index2) {
                                    return Container(
                                        margin: EdgeInsets.fromLTRB(
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                            MediaQuery.of(context).size.height *
                                                0.004,
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                            MediaQuery.of(context).size.height *
                                                0.004),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.03),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    packageList[index2][0],
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0XFF131C24),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: ScreenUtil()
                                                            .setSp(11)),
                                                  ),
                                                  Text(
                                                      packageList[index2][0] ==
                                                              "1 day"
                                                          ? "Her km başına: " +
                                                              carsList[index1]
                                                                  [7] +
                                                              " €"
                                                          : "Ekstra her km başına: " +
                                                              carsList[index1]
                                                                  [7] +
                                                              " €",
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .disabledColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: ScreenUtil()
                                                            .setSp(10),
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.03),
                                              child: Text(
                                                packageList[index2][1] + ' €',
                                                style: TextStyle(
                                                    color:
                                                        const Color(0XFF131C24),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(11)),
                                              ),
                                            ),
                                          ],
                                        ));
                                  },
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0.0,
                      index1 == 0
                          ? MediaQuery.of(context).size.height * 0.02
                          : 0.0,
                      MediaQuery.of(context).size.width * 0.08,
                      0.0),
                  child: SvgPicture.asset(
                    carsList[index1][1],
                    width: MediaQuery.of(context).size.width * 0.14,
                    height: MediaQuery.of(context).size.width * 0.14,
                  ),
                )
              ],
            );
          }),
    );
  }
}
