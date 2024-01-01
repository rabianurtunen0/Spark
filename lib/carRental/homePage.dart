import 'dart:async';
import 'dart:ui' as ui;
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spark_app/carRental/carRentalPage.dart';
import 'package:spark_app/carRental/rentedCarPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng currentLatLng = const LatLng(37.903827, 32.494695);
  LatLng destinationLatLng = const LatLng(0.0, 0.0);
  Set<Polyline> polylines = {};
  double sliderValue = 20.0;
  bool gearManual = true;
  bool gearAutomatic = true;
  bool fuelHybrid = true;
  bool fuelGasoline = true;
  bool fuelElectric = true;

  List<Marker> markersList = [];
  List<LatLng> polylineCoordinates = [];
  List rentalCarList = [];

  String model = '';
  String property = '';
  String gear = '';
  String svgPath = '';
  String walkingMinute = '';
  int fuelPercentage = 100;
  String minutePrice = '';
  String dailyPrice = '';
  String additionalKmFee = '';
  String distance = '';
  String address = '';

  double parseDouble(String value) {
    try {
      value = value.replaceAll(',', '').trim();
      return double.parse(value);
    } catch (e) {
      print('Error parsing double: $value');
      return 0.0;
    }
  }

  static Future<BitmapDescriptor> getBitmapDescriptorFromSvgAsset(
    String assetName, [
    Size size = const Size(48, 48),
  ]) async {
    final pictureInfo = await vg.loadPicture(SvgAssetLoader(assetName), null);

    double devicePixelRatio = ui.window.devicePixelRatio;
    int width = (size.width * devicePixelRatio).toInt();
    int height = (size.height * devicePixelRatio).toInt();

    final scaleFactor = min(
      width / pictureInfo.size.width,
      height / pictureInfo.size.height,
    );

    final recorder = ui.PictureRecorder();

    ui.Canvas(recorder)
      ..scale(scaleFactor)
      ..drawPicture(pictureInfo.picture);

    final rasterPicture = recorder.endRecording();

    final image = rasterPicture.toImageSync(width, height);
    final bytes = (await image.toByteData(format: ui.ImageByteFormat.png))!;

    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }

  getRentalCarInformations() async {
    var collection = FirebaseFirestore.instance.collection('Rental Car');
    var querySnapshot = await collection.get();
    var list = querySnapshot.docs;
    for (int i = 0; i < list.length; i++) {
      rentalCarList.add(list[i].data());
      var data = list[i].data();
    }
    print(rentalCarList);
  }

  double _toRadians(double degrees) {
    return degrees * (pi / 180);
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371000;

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;

    return distance;
  }

  String formatDistance(double distanceInMeters) {
    const double kmThreshold = 1000;

    if (distanceInMeters >= kmThreshold) {
      double distanceInKm = distanceInMeters / 1000;
      return '${distanceInKm.toStringAsFixed(1)} km';
    } else {
      return '${distanceInMeters.toInt()} m';
    }
  }

  double calculateWalkingMinutes(double distanceInMeters) {
    double walkingSpeedMetersPerSecond = 5 / 3.6;
    double walkingTimeInSeconds =
        distanceInMeters / walkingSpeedMetersPerSecond;
    double walkingTimeInMinutes = walkingTimeInSeconds / 60;
    return walkingTimeInMinutes;
  }

  Future<void> generateMarkersList() async {
    BitmapDescriptor bitmapdescriptor = await getBitmapDescriptorFromSvgAsset(
        'assets/images/spark_marker_icon.svg');
    for (int i = 0; i < rentalCarList.length; i++) {
      print(LatLng(rentalCarList[i]['latitude'], rentalCarList[i]['longitude'])
          .toString());
      markersList.add(
        Marker(
          markerId: MarkerId('Marker $i'),
          position: LatLng(
              rentalCarList[i]['latitude'], rentalCarList[i]['longitude']),
          icon: bitmapdescriptor,
          onTap: () {
            setState(() {
              destinationLatLng = LatLng(
                  rentalCarList[i]['latitude'], rentalCarList[i]['longitude']);
              polylineCoordinates = [];
              getPolyPoints();

              double distanceValue = calculateDistance(
                  rentalCarList[i]['latitude'],
                  rentalCarList[i]['longitude'],
                  currentLatLng.latitude,
                  currentLatLng.longitude);
              distance = formatDistance(distanceValue);

              int walkingTime = calculateWalkingMinutes(distanceValue).toInt();
              if (walkingTime < 60) {
                walkingMinute = '$walkingTime min';
              } else {
                walkingMinute = '60+ min';
              }

              model = rentalCarList[i]['model'] ?? '';
              property = rentalCarList[i]['property'] ?? '';
              gear = rentalCarList[i]['gear'] ?? '';
              svgPath =
                  rentalCarList[i]['svgPath'] ?? 'assets/images/mazda_car.svg';
              fuelPercentage = rentalCarList[i]['fuelPercentage'] ?? 100;
              minutePrice = rentalCarList[i]['minutePrice'] ?? '';
              dailyPrice = rentalCarList[i]['dailyPrice'] ?? '';
              additionalKmFee = rentalCarList[i]['additionalKmFee'] ?? '';
              address = rentalCarList[i]['address'] ?? '';
              selectedCar();
            });
          },
        ),
      );
    }
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDwX4rrF6volBhFMEJih9lmAsSDjy6lv8g",
      PointLatLng(currentLatLng.latitude, currentLatLng.longitude),
      PointLatLng(destinationLatLng.latitude, destinationLatLng.longitude),
      travelMode: TravelMode.driving,
      avoidHighways: true,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      polylines.add(Polyline(
        polylineId: const PolylineId("route"),
        points: polylineCoordinates,
        color: Theme.of(context).primaryColorDark,
        width: 4,
        endCap: Cap.buttCap,
        startCap: Cap.buttCap,
      ));
      setState(() {});
    }
  }

  void filters() async {
    var collection = FirebaseFirestore.instance.collection('Rental Car');
    var querySnapshot = await collection.get();
    var list = querySnapshot.docs;
    var rentalCarList2 = [];
    for (int i = 0; i < list.length; i++) {
      rentalCarList2.add(list[i].data());
      var data = list[i].data();
    }
    rentalCarList2
        .removeWhere((car) => car['fuelPercentage'] < sliderValue.toInt());
    setState(() {
      rentalCarList = rentalCarList2;
    });
    if (gearManual == false) {
      rentalCarList2.removeWhere((car) => car['gear'] == 'Manual');
      setState(() {
        rentalCarList = rentalCarList2;
      });
    }
    if (gearAutomatic == false) {
      rentalCarList2.removeWhere((car) => car['gear'] == 'Automatic');
      setState(() {
        rentalCarList = rentalCarList2;
      });
    }
    if (fuelGasoline == false) {
      rentalCarList2.removeWhere((car) => car['fuel'] == 'Gasoline');
      setState(() {
        rentalCarList = rentalCarList2;
      });
    }
    if (fuelHybrid == false) {
      rentalCarList2.removeWhere((car) => car['fuel'] == 'Hybrid');
      setState(() {
        rentalCarList = rentalCarList2;
      });
    }
    if (fuelElectric == false) {
      rentalCarList2.removeWhere((car) => car['fuel'] == 'Electric');
      setState(() {
        rentalCarList = rentalCarList2;
      });
    }
    markersList = [];
    await generateMarkersList();
    print(rentalCarList.length);
    setState(() {});
  }

  void initializeData() async {
    await getRentalCarInformations();
    await generateMarkersList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition:
                CameraPosition(target: currentLatLng, zoom: 16.0),
            onMapCreated: (controller) {
              setState(() {
                _controller = Completer<GoogleMapController>();
                _controller.complete(controller);
              });
            },
            markers: Set<Marker>.of(markersList),
            polylines: polylines,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2,
                MediaQuery.of(context).size.height * 0.09, 0.0, 0.0),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              children: [
                MaterialButton(
                  highlightElevation: 4.0,
                  color: Theme.of(context).cardColor,
                  splashColor: const Color(0XFF53799A),
                  highlightColor: const Color(0XFF53799A),
                  onPressed: () {
                    selectFilters();
                    polylines.clear();
                    setState(() {});
                  },
                  shape: CircleBorder(
                    side: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  child: Icon(
                    BootstrapIcons.funnel_fill,
                    color: Theme.of(context).primaryColor,
                    size: ScreenUtil().setSp(16),
                  ),
                ),
                MaterialButton(
                  highlightElevation: 4.0,
                  color: Theme.of(context).cardColor,
                  splashColor: const Color(0XFF53799A),
                  highlightColor: const Color(0XFF53799A),
                  onPressed: () {
                    setState(() {
                      Get.to(const RentedCarPage());
                    });
                  },
                  shape: CircleBorder(
                    side: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  child: Icon(
                    BootstrapIcons.car_front_fill,
                    color: Theme.of(context).primaryColor,
                    size: ScreenUtil().setSp(16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  selectedCar() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.04),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.38,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(24.0),
                              bottom: Radius.zero,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            MediaQuery.of(context).size.width *
                                                0.06,
                                            MediaQuery.of(context).size.height *
                                                0.048,
                                            MediaQuery.of(context).size.width *
                                                0.06,
                                            MediaQuery.of(context).size.height *
                                                0.004),
                                        child: Text(model,
                                            style: TextStyle(
                                              color: const Color(0XFF131C24),
                                              fontWeight: FontWeight.w500,
                                              fontSize: ScreenUtil().setSp(13),
                                            )),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            MediaQuery.of(context).size.width *
                                                0.06,
                                            0.0,
                                            MediaQuery.of(context).size.width *
                                                0.06,
                                            MediaQuery.of(context).size.height *
                                                0.012),
                                        child: Text(property,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .disabledColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: ScreenUtil().setSp(11),
                                            )),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                        MediaQuery.of(context).size.height *
                                            0.04,
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                        MediaQuery.of(context).size.height *
                                            0.004),
                                    width: MediaQuery.of(context).size.width *
                                        0.24,
                                    height: MediaQuery.of(context).size.height *
                                        0.028,
                                    decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: Center(
                                      child: Text(distance,
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
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
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
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                              0.0,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          child: Text(
                                            walkingMinute,
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
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                              0.0,
                                              0.0),
                                          child: SvgPicture.asset(
                                            'assets/images/gear_stick.svg',
                                            //color: const Color(0XFF131C24),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.028,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.028,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                              0.0,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          child: Text(
                                            gear,
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
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                                0.0,
                                                0.0),
                                            child: Icon(
                                              BootstrapIcons.fuel_pump,
                                              color: const Color(0XFF131C24),
                                              size: ScreenUtil().setSp(10),
                                            )),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                              0.0,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          child: Text(
                                            '$fuelPercentage%',
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
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                                0.0,
                                                0.0),
                                            child: Icon(
                                              BootstrapIcons.bag_fill,
                                              color: const Color(0XFF131C24),
                                              size: ScreenUtil().setSp(10),
                                            )),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                              0.0,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
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
                                      '$minutePrice €',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(17),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      child: Text(
                                        '/ minute',
                                        style: TextStyle(
                                          color:
                                              Theme.of(context).disabledColor,
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
                                      '$dailyPrice €',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(17),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      child: Text(
                                        '/ daily (+ €$additionalKmFee/km)',
                                        style: TextStyle(
                                          color:
                                              Theme.of(context).disabledColor,
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
                                    MediaQuery.of(context).size.height * 0.022,
                                    0.0,
                                    0.0),
                                width: MediaQuery.of(context).size.width * 0.68,
                                height:
                                    MediaQuery.of(context).size.height * 0.048,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      Get.to(CarRentalPage(
                                          svgPath: svgPath,
                                          model: model,
                                          property: property,
                                          distance: distance,
                                          walkingMinute: walkingMinute,
                                          gear: gear,
                                          fuelPercentage: fuelPercentage,
                                          dailyPrice: dailyPrice,
                                          minutePrice: minutePrice,
                                          additionalKmFee: additionalKmFee,
                                          address: address));
                                    });
                                  },
                                  child: const Text('Rent'),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.08),
                      child: SvgPicture.asset(
                        svgPath,
                        width: MediaQuery.of(context).size.width * 0.14,
                        height: MediaQuery.of(context).size.width * 0.14,
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }

  selectFilters() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24.0),
                    bottom: Radius.zero,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.012),
                    child: SvgPicture.asset(
                      'assets/images/line.svg',
                      height: MediaQuery.of(context).size.height * 0.0048,
                      color: const Color(0XFFB8BCC1),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.06),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Color(0XFF131C24),
                        width: 0.15,
                      ))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Filters',
                            style: TextStyle(
                              color: const Color(0XFF131C24),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(13),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                gearManual = true;
                                gearAutomatic = true;
                                fuelGasoline = true;
                                fuelHybrid = true;
                                fuelElectric = true;
                                sliderValue = 20.0;
                              });
                            },
                            child: Text(
                              'Clear all',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(10),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.07),
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02),
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Minimum fuel level',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: const Color(0XFF131C24),
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(12),
                          ),
                        ),
                        Text(
                          sliderValue.toString(),
                          style: TextStyle(
                            color: const Color(0XFF131C24),
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(11),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04),
                    child: Slider(
                      value: sliderValue,
                      max: 100,
                      divisions: 20,
                      label: sliderValue.toString(),
                      onChanged: (value) {
                        setState(() {
                          sliderValue = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.07,
                    ),
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.02),
                    height: MediaQuery.of(context).size.height * 0.04,
                    child: Text(
                      'Gear',
                      style: TextStyle(
                        color: const Color(0XFF131C24),
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(12),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                    ),
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.02),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.02,
                            MediaQuery.of(context).size.height * 0.01,
                            MediaQuery.of(context).size.width * 0.01,
                            MediaQuery.of(context).size.height * 0.01,
                          ),
                          height: MediaQuery.of(context).size.height * 0.036,
                          child: OutlinedButton(
                            style: ButtonStyle(
                                backgroundColor: gearManual
                                    ? MaterialStateProperty.all<Color>(
                                        const Color(0XFF89A6BF))
                                    : MaterialStateProperty.all<Color>(
                                        Colors.transparent),
                                overlayColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.transparent),
                                side: MaterialStateProperty.all<BorderSide>(
                                    const BorderSide(
                                        color: Color(0XFF89A6BF), width: 1.0))),
                            onPressed: () {
                              setState(() {
                                gearManual = !gearManual;
                              });
                            },
                            child: Text(
                              'Manual',
                              style: TextStyle(
                                color: gearManual
                                    ? Colors.white
                                    : const Color(0XFF131C24),
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(12),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.01,
                            MediaQuery.of(context).size.height * 0.01,
                            MediaQuery.of(context).size.width * 0.02,
                            MediaQuery.of(context).size.height * 0.01,
                          ),
                          height: MediaQuery.of(context).size.height * 0.036,
                          child: OutlinedButton(
                              style: ButtonStyle(
                                  backgroundColor: gearAutomatic
                                      ? MaterialStateProperty.all<Color>(
                                          const Color(0XFF89A6BF),
                                        )
                                      : MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  overlayColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => Colors.transparent),
                                  side: MaterialStateProperty.all<BorderSide>(
                                      const BorderSide(
                                          color: Color(0XFF89A6BF),
                                          width: 1.0))),
                              onPressed: () {
                                setState(() {
                                  gearAutomatic = !gearAutomatic;
                                });
                              },
                              child: Text(
                                'Automatic',
                                style: TextStyle(
                                  color: gearAutomatic
                                      ? Colors.white
                                      : const Color(0XFF131C24),
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(12),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.07,
                    ),
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.02),
                    height: MediaQuery.of(context).size.height * 0.04,
                    child: Text(
                      'Fuel',
                      style: TextStyle(
                        color: const Color(0XFF131C24),
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(12),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                    ),
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.02),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.02,
                            MediaQuery.of(context).size.height * 0.01,
                            MediaQuery.of(context).size.width * 0.01,
                            MediaQuery.of(context).size.height * 0.01,
                          ),
                          height: MediaQuery.of(context).size.height * 0.036,
                          child: OutlinedButton(
                            style: ButtonStyle(
                                backgroundColor: fuelGasoline
                                    ? MaterialStateProperty.all<Color>(
                                        const Color(0XFF89A6BF))
                                    : MaterialStateProperty.all<Color>(
                                        Colors.transparent),
                                overlayColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.transparent),
                                side: MaterialStateProperty.all<BorderSide>(
                                    const BorderSide(
                                        color: Color(0XFF89A6BF), width: 1.0))),
                            onPressed: () {
                              setState(() {
                                fuelGasoline = !fuelGasoline;
                              });
                            },
                            child: Text(
                              'Gasoline',
                              style: TextStyle(
                                color: fuelGasoline
                                    ? Colors.white
                                    : const Color(0XFF131C24),
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(12),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.01,
                            MediaQuery.of(context).size.height * 0.01,
                            MediaQuery.of(context).size.width * 0.02,
                            MediaQuery.of(context).size.height * 0.01,
                          ),
                          height: MediaQuery.of(context).size.height * 0.036,
                          child: OutlinedButton(
                            style: ButtonStyle(
                                backgroundColor: fuelHybrid
                                    ? MaterialStateProperty.all<Color>(
                                        const Color(0XFF89A6BF))
                                    : MaterialStateProperty.all<Color>(
                                        Colors.transparent),
                                overlayColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.transparent),
                                side: MaterialStateProperty.all<BorderSide>(
                                    const BorderSide(
                                        color: Color(0XFF89A6BF), width: 1.0))),
                            onPressed: () {
                              setState(() {
                                fuelHybrid = !fuelHybrid;
                              });
                            },
                            child: Text(
                              'Hybrid',
                              style: TextStyle(
                                color: fuelHybrid
                                    ? Colors.white
                                    : const Color(0XFF131C24),
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(12),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.01,
                            MediaQuery.of(context).size.height * 0.01,
                            MediaQuery.of(context).size.width * 0.02,
                            MediaQuery.of(context).size.height * 0.01,
                          ),
                          height: MediaQuery.of(context).size.height * 0.036,
                          child: OutlinedButton(
                            style: ButtonStyle(
                                backgroundColor: fuelElectric
                                    ? MaterialStateProperty.all<Color>(
                                        const Color(0XFF89A6BF))
                                    : MaterialStateProperty.all<Color>(
                                        Colors.transparent),
                                overlayColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.transparent),
                                side: MaterialStateProperty.all<BorderSide>(
                                    const BorderSide(
                                        color: Color(0XFF89A6BF), width: 1.0))),
                            onPressed: () {
                              setState(() {
                                fuelElectric = !fuelElectric;
                              });
                            },
                            child: Text(
                              'Electric',
                              style: TextStyle(
                                color: fuelElectric
                                    ? Colors.white
                                    : const Color(0XFF131C24),
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0,
                        MediaQuery.of(context).size.height * 0.036, 0.0, 0.0),
                    width: MediaQuery.of(context).size.width * 0.68,
                    height: MediaQuery.of(context).size.height * 0.048,
                    child: ElevatedButton(
                      onPressed: () {
                        filters();
                        setState(() {
                          print(markersList);
                          Navigator.pop(context);
                        });
                      },
                      child: const Text('Show results'),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
}
