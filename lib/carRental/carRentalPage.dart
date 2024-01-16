import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';
import 'package:spark_app/carRental/payment.dart';

class CarRentalPage extends StatefulWidget {
  String svgPath,
      model,
      property,
      distance,
      walkingMinute,
      gear,
      dailyPrice,
      minutePrice,
      additionalKmFee,
      address;
  int fuelPercentage;

  CarRentalPage(
      {super.key,
      required this.svgPath,
      required this.model,
      required this.property,
      required this.distance,
      required this.walkingMinute,
      required this.gear,
      required this.fuelPercentage,
      required this.dailyPrice,
      required this.minutePrice,
      required this.additionalKmFee,
      required this.address});

  @override
  State<CarRentalPage> createState() => _CarRentalPageState();
}

class _CarRentalPageState extends State<CarRentalPage> {
  BuildContext? _alertDialog, _bottomSheet;
  final _scrollController = ScrollController();
  final _scrollController2 = ScrollController();

  bool showPackage = false;
  int hourlyAndDailyPackageButtonNumber = 3;

  final date = DateFormat('dd/MM/yyyy').format(DateTime.now());
  DateTime nowTime = DateTime.now();
  DateTime time1 = DateTime.now();
  DateTime time2 = DateTime.now().add(const Duration(days: 1));
  bool startTimeBar = false;
  bool endTimeBar = false;
  String timeAndKm = '1 day';
  String price = '';
  double oneDayPrice = 0.0;
  String firstPerKm = '';
  String perKm = '';
  //String selectedtimeAndKm = '1 day';
  //int selectedHourlyAndDailyPackageButtonNumber = 3;
  //String selectedPerKm = '';
  //String selectedPrice = '';

  DateTime roundToNextDayAndHour() {
    DateTime now = DateTime.now();
    int currentHour = now.hour;
    int currentMinute = now.minute;

    if (currentMinute > 0) {
      currentHour++;
    }

    return DateTime(now.year, now.month, now.day + 1, currentHour, 0, 0);
  }

  void calculateDateDifference(DateTime time1, DateTime time2) async {
    Duration difference = time2.difference(time1);
    int daysDifference = difference.inDays;
    int hoursDifference = difference.inHours % 24;
    double sixHoursPrice = oneDayPrice / 4.0;
    price = ((oneDayPrice * daysDifference) +
            ((hoursDifference ~/ 6) * sixHoursPrice))
        .toString();

    if (daysDifference == 0) {
      if (hoursDifference == 0) {
        timeAndKm = "0 day";
      } else if (hoursDifference == 1) {
        timeAndKm = "$hoursDifference hour";
      } else {
        timeAndKm = "$daysDifference hours";
      }
    } else if (daysDifference == 1) {
      if (hoursDifference == 0) {
        timeAndKm = "$daysDifference day";
      } else if (hoursDifference == 1) {
        timeAndKm = "$daysDifference day $hoursDifference hour";
      } else {
        timeAndKm = "$daysDifference day $hoursDifference hours";
      }
    } else {
      if (hoursDifference == 0) {
        timeAndKm = "$daysDifference days";
      } else if (hoursDifference == 1) {
        timeAndKm = "$daysDifference days $hoursDifference hour";
      } else {
        timeAndKm = "$daysDifference days $hoursDifference hours";
      }
    }

    timeAndKm == '1 day'
        ? hourlyAndDailyPackageButtonNumber = 3
        : hourlyAndDailyPackageButtonNumber = 1000;

    perKm = firstPerKm;
    /*
      if (selectedtimeAndKm.contains(timeAndKm)) {
        print('selectedtimeAndKm:   $selectedtimeAndKm');
        print('TİME and Km : $timeAndKm');
        timeAndKm = selectedtimeAndKm;
        perKm = selectedPerKm;
        price = selectedPrice;
        hourlyAndDailyPackageButtonNumber =
            selectedHourlyAndDailyPackageButtonNumber;
      }
      */
      setState(() {
        
      });
  }

  getInformation() async {
    var collection = FirebaseFirestore.instance
        .collection('Cars')
        .doc(widget.model)
        .collection('Packages');
    var querySnapshot = await collection.get();
    var list = querySnapshot.docs;
    for (int i = 0; i < list.length; i++) {
      setState(() {
        if (list[i]["timeAndKm"] == "1 day") {
          int dayPrice = list[i]['price'];
          price = dayPrice.toString();
          oneDayPrice = dayPrice.toDouble();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    time2 = roundToNextDayAndHour();
    getInformation();
    perKm = 'Per km: ${widget.additionalKmFee} €';
    firstPerKm = 'Per km: ${widget.additionalKmFee} €';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
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
              color: Color(0XFF131C24).withOpacity(0.8),
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.042),
                    child: SvgPicture.asset('assets/images/shadow.svg',
                        width: MediaQuery.of(context).size.width * 0.68),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0.0,
                        MediaQuery.of(context).size.height * 0.04,
                        0.0,
                        MediaQuery.of(context).size.height * 0.048),
                    child: SvgPicture.asset(widget.svgPath,
                        width: MediaQuery.of(context).size.width * 0.48),
                  ),
                ],
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
                                  MediaQuery.of(context).size.width * 0.06,
                                  MediaQuery.of(context).size.height * 0.018,
                                  MediaQuery.of(context).size.width * 0.06,
                                  MediaQuery.of(context).size.height * 0.004),
                              child: Text(widget.model,
                                  style: TextStyle(
                                    color: const Color(0XFF131C24),
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(13),
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.06,
                                  0.0,
                                  MediaQuery.of(context).size.width * 0.06,
                                  MediaQuery.of(context).size.height * 0.012),
                              child: Text(widget.property,
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
                              MediaQuery.of(context).size.width * 0.024,
                              MediaQuery.of(context).size.height * 0.004),
                          width: MediaQuery.of(context).size.width * 0.24,
                          height: MediaQuery.of(context).size.height * 0.028,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Center(
                            child: Text(widget.distance,
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
                                  widget.walkingMinute,
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
                                  widget.gear,
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
                                  '${widget.fuelPercentage}%',
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
                          MediaQuery.of(context).size.width * 0.06,
                          0.0,
                          MediaQuery.of(context).size.width * 0.06,
                          MediaQuery.of(context).size.height * 0.008),
                      child: Row(
                        children: [
                          Text(
                            '${widget.minutePrice} €',
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
                          MediaQuery.of(context).size.width * 0.06,
                          0.0,
                          MediaQuery.of(context).size.width * 0.06,
                          MediaQuery.of(context).size.height * 0.008),
                      child: Row(
                        children: [
                          Text(
                            '${widget.dailyPrice} €',
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
                                  ' ${widget.additionalKmFee} €',
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
                          widget.address,
                          style: TextStyle(
                            color: const Color(0XFF131C24),
                            fontWeight: FontWeight.w400,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.248,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Cars')
                            .doc(widget.model)
                            .collection('Packages')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              controller: _scrollController2,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context, index1) {
                                DocumentSnapshot documentData =
                                    snapshot.data!.docs[index1];
                                print(snapshot.data!.docs[index1]);
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
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
                                          timeAndKm = documentData["timeAndKm"];
                                          price =
                                              documentData["price"].toString();
                                          if (timeAndKm.contains('1 hour')) {
                                            time2 = DateTime.now()
                                                .add(const Duration(hours: 1));
                                          } else if (timeAndKm
                                              .contains('2 hours')) {
                                            time2 = DateTime.now()
                                                .add(const Duration(hours: 2));
                                          } else if (timeAndKm
                                              .contains('3 hours')) {
                                            time2 = DateTime.now()
                                                .add(const Duration(hours: 3));
                                          } else if (timeAndKm
                                              .contains('5 hours')) {
                                            time2 = DateTime.now()
                                                .add(const Duration(hours: 5));
                                          } else if (timeAndKm
                                              .contains('8 hours')) {
                                            time2 = DateTime.now()
                                                .add(const Duration(hours: 8));
                                          } else if (timeAndKm
                                              .contains('1 day')) {
                                            time2 = DateTime.now()
                                                .add(const Duration(days: 1));
                                          } else if (timeAndKm
                                              .contains('2 days')) {
                                            time2 = DateTime.now()
                                                .add(const Duration(days: 2));
                                          } else if (timeAndKm
                                              .contains('3 days')) {
                                            time2 = DateTime.now()
                                                .add(const Duration(days: 3));
                                          } else if (timeAndKm
                                              .contains('5 days')) {
                                            time2 = DateTime.now()
                                                .add(const Duration(days: 5));
                                          } else if (timeAndKm
                                              .contains('7 days')) {
                                            time2 = DateTime.now()
                                                .add(const Duration(days: 7));
                                          } else if (timeAndKm
                                              .contains('14 days')) {
                                            time2 = DateTime.now()
                                                .add(const Duration(days: 14));
                                          }
                                          documentData["timeAndKm"] == "1 day"
                                              ? perKm = 'Per km: 0.12 €'
                                              : perKm = 'Per extra km: 0.12 €';
                                          /*
                                          selectedtimeAndKm = timeAndKm;
                                          selectedHourlyAndDailyPackageButtonNumber =
                                              index1;
                                          selectedPerKm = perKm;
                                          selectedPrice = price;
                                          */
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
                                                documentData["timeAndKm"],
                                                style: TextStyle(
                                                    color:
                                                        const Color(0XFF131C24),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(11)),
                                              ),
                                              Text(
                                                  documentData["timeAndKm"] ==
                                                          "1 day"
                                                      ? 'Per km: 0.12 €'
                                                      : 'Per extra km: 0.12 €',
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
                                            '${documentData["price"]} €',
                                            style: TextStyle(
                                                color: const Color(0XFF131C24),
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    ScreenUtil().setSp(11)),
                                          ),
                                        ],
                                      ),
                                    ));
                              },
                            );
                          } else {
                            return Container();
                          }
                        },
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
                    ? MediaQuery.of(context).size.height * 0.28
                    : endTimeBar
                        ? MediaQuery.of(context).size.height * 0.28
                        : MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.78,
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
                                fontSize: ScreenUtil().setSp(11),
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
                                        calculateDateDifference(time1, time2);
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
                      width: MediaQuery.of(context).size.width * 0.78,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        border: endTimeBar
                            ? Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).disabledColor,
                                  width: 0.3,
                                ),
                              )
                            : const Border(),
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
                                fontSize: ScreenUtil().setSp(11),
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
                                        calculateDateDifference(time1, time2);
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
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.06),
                width: MediaQuery.of(context).size.width * 0.86,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(
                              0.0,
                              MediaQuery.of(context).size.height * 0.015,
                              0.0,
                              MediaQuery.of(context).size.height * 0.01),
                          child: Text(
                            'Rental Price',
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenUtil().setSp(12)),
                          ),
                        ),
                        Text(
                          timeAndKm,
                          style: TextStyle(
                              color: const Color(0XFF131C24),
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(11)),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.015),
                          child: Text(perKm,
                              style: TextStyle(
                                color: Theme.of(context).disabledColor,
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(10),
                              )),
                        )
                      ],
                    ),
                    Text(
                      ' $price €',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(17),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0.0,
                    MediaQuery.of(context).size.height * 0.022,
                    0.0,
                    MediaQuery.of(context).size.height * 0.088),
                width: MediaQuery.of(context).size.width * 0.68,
                height: MediaQuery.of(context).size.height * 0.048,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Payment payment = Payment(timeAndKm, price);
                      payment.showPaymentScreen(context);
                    });
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
