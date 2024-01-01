import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CarsAndPricesPage extends StatefulWidget {
  const CarsAndPricesPage({super.key});

  @override
  State<CarsAndPricesPage> createState() => _CarsAndPricesPageState();
}

class _CarsAndPricesPageState extends State<CarsAndPricesPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Cars').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.data?.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentData = snapshot.data!.docs[index];
                  print(snapshot.data!.docs[index]);
                  return showCars(
                    svgPath: documentData["svgPath"],
                    model: documentData["model"],
                    property: documentData["property"],
                    gear: documentData["gear"],
                    fuel: documentData["fuel"],
                    minutePrice: documentData["minutePrice"],
                    dailyPrice: documentData["dailyPrice"],
                    additionalKmFee: documentData["additionalKmFee"],
                    first: index == 0 ? true : false,
                    last:
                        index == snapshot.data!.docs.length - 1 ? true : false,
                    index: index,
                  );
                });
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class showCars extends StatefulWidget {
  String svgPath,
      model,
      property,
      gear,
      fuel,
      minutePrice,
      dailyPrice,
      additionalKmFee;
  bool first, last;
  int index;

  showCars({
    Key? key,
    required this.svgPath,
    required this.model,
    required this.property,
    required this.gear,
    required this.fuel,
    required this.minutePrice,
    required this.dailyPrice,
    required this.additionalKmFee,
    required this.first,
    required this.last,
    required this.index,
  }) : super(key: key);

  @override
  State<showCars> createState() => _showCarsState();
}

class _showCarsState extends State<showCars> {
  final _scrollController = ScrollController();

  String packageIcon = "";
  String package = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.05,
              widget.first
                  ? MediaQuery.of(context).size.height * 0.05
                  : MediaQuery.of(context).size.height * 0.025,
              MediaQuery.of(context).size.width * 0.05,
              widget.last
                  ? MediaQuery.of(context).size.height * 0.05
                  : MediaQuery.of(context).size.height * 0.025),
          height: package == widget.index.toString()
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
                child: Text(widget.model,
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
                child: Text(widget.property,
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
                              MediaQuery.of(context).size.height * 0.01),
                          child: SvgPicture.asset(
                            'assets/images/gear_stick.svg',
                            //color: const Color(0XFF131C24),
                            width: MediaQuery.of(context).size.width * 0.028,
                            height: MediaQuery.of(context).size.width * 0.028,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.005,
                              MediaQuery.of(context).size.height * 0.01,
                              MediaQuery.of(context).size.width * 0.025,
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
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.025,
                                MediaQuery.of(context).size.height * 0.01,
                                MediaQuery.of(context).size.width * 0.005,
                                MediaQuery.of(context).size.height * 0.01),
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
                              MediaQuery.of(context).size.height * 0.01),
                          child: Text(
                            widget.fuel,
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
                      '${widget.minutePrice} €',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(17),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.02),
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
                      '${widget.dailyPrice} €',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(17),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.02),
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
                          vertical: MediaQuery.of(context).size.height * 0.01),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Insurance',
                                style: TextStyle(
                                    color: Theme.of(context).disabledColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(10))),
                            Text(
                              'Free',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontWeight: FontWeight.w700,
                                  fontSize: ScreenUtil().setSp(10)),
                            ),
                          ]),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01),
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
                                color: Theme.of(context).primaryColorLight,
                                fontWeight: FontWeight.w700,
                                fontSize: ScreenUtil().setSp(10)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01),
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
                            '${widget.additionalKmFee} €',
                            style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
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
                        package == widget.index.toString()
                            ? package = ""
                            : package = widget.index.toString();
                        packageIcon == widget.index.toString()
                            ? packageIcon = ""
                            : packageIcon = widget.index.toString();
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
                              left: MediaQuery.of(context).size.width * 0.054),
                          onPressed: () {
                            setState(() {
                              package == widget.index.toString()
                                  ? package = ""
                                  : package = widget.index.toString();
                              packageIcon == widget.index.toString()
                                  ? packageIcon = ""
                                  : packageIcon = widget.index.toString();
                            });
                          },
                          splashRadius: 1.0,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(
                            packageIcon == widget.index.toString()
                                ? BootstrapIcons.chevron_up
                                : BootstrapIcons.chevron_down,
                            size: ScreenUtil().setSp(16),
                            color: Theme.of(context).primaryColorDark,
                          ),
                        )
                      ],
                    ),
                  )),
              package == widget.index.toString()
                  ? StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Cars')
                          .doc(widget.model)
                          .collection('Packages')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.248,
                            child: ListView.builder(
                                controller: _scrollController,
                                itemCount: snapshot.data?.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot documentData =
                                      snapshot.data!.docs[index];
                                  print(snapshot.data!.docs[index]);
                                  return showPackages(
                                      timeAndKm: documentData["timeAndKm"],
                                      price: documentData["price"],
                                      additionalKmFee: widget.additionalKmFee);
                                }),
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  : Container(),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              0.0,
              widget.index == 0
                  ? MediaQuery.of(context).size.height * 0.02
                  : 0.0,
              MediaQuery.of(context).size.width * 0.08,
              0.0),
          child: SvgPicture.asset(
            widget.svgPath,
            width: MediaQuery.of(context).size.width * 0.14,
            height: MediaQuery.of(context).size.width * 0.14,
          ),
        ),
      ],
    );
  }
}

class showPackages extends StatefulWidget {
  String timeAndKm, price, additionalKmFee;

  showPackages({
    Key? key,
    required this.timeAndKm,
    required this.price,
    required this.additionalKmFee,
  }) : super(key: key);

  @override
  State<showPackages> createState() => _showPackagesState();
}

class _showPackagesState extends State<showPackages> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.04,
            MediaQuery.of(context).size.height * 0.004,
            MediaQuery.of(context).size.width * 0.04,
            MediaQuery.of(context).size.height * 0.004),
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.timeAndKm,
                    style: TextStyle(
                        color: const Color(0XFF131C24),
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(11)),
                  ),
                  Text(
                      widget.timeAndKm == "1 day"
                          ? "Per km: ${widget.additionalKmFee} €"
                          : "Per extra km: ${widget.additionalKmFee} €",
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(10),
                      ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03),
              child: Text(
                '${widget.price} €',
                style: TextStyle(
                    color: const Color(0XFF131C24),
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(11)),
              ),
            ),
          ],
        ));
  }
}
