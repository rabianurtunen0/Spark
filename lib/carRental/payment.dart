import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:spark_app/carRental/serviceArea.dart';

class Payment {
  BuildContext? _alertDialog, _bottomSheet;
  String timeAndKm;
  String price;

  Payment(this.timeAndKm, this.price);

  bool paymentLoading = false;
  final savedCardNumberEditingController =
      TextEditingController(text: '1234 **** **** 5678');
  final cardNumberEditingController = TextEditingController();
  final cardholderNameEditingController = TextEditingController();
  final cvvEditingController = TextEditingController();
  final expirationDateEditingController = TextEditingController();
  bool changeCardLoading = false;

  List creditCardNumbers = [
    '1234 **** **** 5678',
    '5678 **** **** 1234',
  ];

  bool anotherCreditCard = false;
  bool saveCreditCard = false;
  int creditCardValue = 0;

  void onCreditCardChanged(int value) {
    creditCardValue = value;
  }

  bool isClosedBottomSheet = false;

  void onPaymentOptionChanged(int value) {
    creditCardValue = value;
    savedCardNumberEditingController.text = creditCardNumbers[value];
  }

  void showPaymentScreen(BuildContext context) {
    void getCreditCardValue(Function(int) onCreditCardChanged) {
      creditCardValue;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          _alertDialog = context;
          return AlertDialog(
            backgroundColor: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            titlePadding: EdgeInsets.zero,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.025),
                  child: Icon(
                    BootstrapIcons.exclamation_circle_fill,
                    color: Theme.of(context).primaryColor,
                    size: ScreenUtil().setSp(50),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.12,
                      0.0,
                      MediaQuery.of(context).size.width * 0.12,
                      MediaQuery.of(context).size.height * 0.02),
                  child: Text(
                    'The vehicle you selected is reserved for you within the specified time range',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(14)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.06,
                    0.0,
                    MediaQuery.of(context).size.width * 0.06,
                    MediaQuery.of(context).size.height * 0.03,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Please leave the vehicle within the ',
                      style: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(11)),
                      children: [
                        TextSpan(
                          text: 'service area',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0XFF131C24),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                Get.to(const ServiceAreaPage());
                              });
                            },
                        ),
                        const TextSpan(
                          text:
                              '. Otherwise, the vehicle will not be considered delivered. If you exceed your rental period without extending it, you will be charged 40 € for each additional day. And if you do not pay your fine or do not return the vehicle after three days, legal proceedings will be initiated.',
                        ),
                      ],
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'assets/images/dashed_lines.svg',
                  color: Theme.of(context).disabledColor,
                ),
              ],
            ),
            actions: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.008,
                    MediaQuery.of(context).size.height * 0.006,
                    MediaQuery.of(context).size.width * 0.008,
                    MediaQuery.of(context).size.height * 0.006),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //textDirection: TextDirection.ltr,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.016),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rental duration',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: const Color(0XFF131C24),
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(11)),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.004),
                            child: Text(
                              timeAndKm,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: ScreenUtil().setSp(12)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.016),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rental fee',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: const Color(0XFF131C24),
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(11)),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.004),
                              child: Text(
                                '$price €',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenUtil().setSp(12)),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.88,
                alignment: Alignment.center,
                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.008),
                height: MediaQuery.of(context).size.height * 0.048,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0)),
                child: MaterialButton(
                  elevation: 0,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    anotherCreditCard = false;
                    changeCreditCard(context);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/box.svg',
                        color: Theme.of(context).cardColor,
                        width: MediaQuery.of(context).size.width * 0.028,
                        height: MediaQuery.of(context).size.height * 0.032,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.width * 0.036),
                            child: Text(
                              'Card',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: const Color(0XFF878999),
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(12)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.width * 0.036),
                            child: Text(
                              savedCardNumberEditingController.text,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(11),
                                color: const Color(0XFF131622),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.022),
                  width: MediaQuery.of(context).size.width * 0.68,
                  height: MediaQuery.of(context).size.height * 0.046,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        paymentLoading = true;
                      });
                      Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          paymentLoading = false;
                          Get.back();
                          Get.back();
                        });
                      });
                      setState(() {});
                    },
                    child: paymentLoading
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.height * 0.03,
                            child: const CircularProgressIndicator(
                              color: Color(0XFFFFFDFA),
                              strokeWidth: 2.0,
                            ),
                          )
                        : const Text('PAY'),
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  changeCreditCard(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        _bottomSheet = context;
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
                width: MediaQuery.of(context).size.width,
                height: anotherCreditCard
                    ? ((creditCardNumbers.length + 1) *
                            MediaQuery.of(context).size.height *
                            0.074) +
                        MediaQuery.of(context).size.height * 0.5
                    : (creditCardNumbers.length + 1) *
                        MediaQuery.of(context).size.height *
                        0.074,
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.018,
                    horizontal: MediaQuery.of(context).size.width * 0.036),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24.0),
                    bottom: Radius.zero,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: creditCardNumbers.length * 50,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          //physics: const NeverScrollableScrollPhysics(),
                          itemCount: creditCardNumbers.length,
                          itemBuilder: (context, index) {
                            return Container(
                              alignment: Alignment.center,
                              height: 48,
                              child: Material(
                                elevation: 0,
                                color: Theme.of(context).cardColor,
                                child: MaterialButton(
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height: 40,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/box.svg',
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.028,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.032,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.036),
                                            child: Text(
                                              creditCardNumbers[index],
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    ScreenUtil().setSp(11),
                                                color: const Color(0XFF131C24),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Transform.scale(
                                        scale: 0.9,
                                        child: Radio(
                                          value: index,
                                          groupValue: creditCardValue,
                                          onChanged: (value) {
                                            setState(() {
                                              print(value);
                                              creditCardValue = value!;
                                              Navigator.pop(context);
                                              isClosedBottomSheet = true;
                                              onPaymentOptionChanged(value);
                                              savedCardNumberEditingController
                                                      .text =
                                                  creditCardNumbers[value];
                                              Navigator.of(_alertDialog
                                                      as BuildContext)
                                                  .pop();
                                              showPaymentScreen(context);
                                            });
                                          },
                                          fillColor:
                                              MaterialStateColor.resolveWith(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.selected)) {
                                                return Theme.of(context)
                                                    .primaryColor;
                                              }
                                              return Theme.of(context)
                                                  .highlightColor;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      creditCardValue = index;
                                      onCreditCardChanged(index);
                                      Navigator.pop(context);
                                      isClosedBottomSheet = true;
                                      onPaymentOptionChanged(index);
                                      savedCardNumberEditingController.text =
                                          creditCardNumbers[index];
                                      Navigator.of(
                                        _alertDialog!,
                                      ).pop();
                                      showPaymentScreen(context);
                                    });
                                  },
                                ),
                              ),
                            );
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 0.025),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: anotherCreditCard
                            ? Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).disabledColor,
                                  width: 0.2,
                                ),
                              )
                            : const Border(),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            anotherCreditCard = true;
                          });
                        },
                        style: ButtonStyle(
                          shadowColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ANOTHER CARD',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenUtil().setSp(11),
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                      ),
                    ),
                    anotherCreditCard
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.06),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.022,
                                      MediaQuery.of(context).size.height *
                                          0.028,
                                      0.0,
                                      MediaQuery.of(context).size.height *
                                          0.008),
                                  child: Text(
                                    'Card Number',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: ScreenUtil().setSp(11),
                                      color: const Color(0XFF131C24),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.052,
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: cardNumberEditingController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(16),
                                      CardNumberFormatter(),
                                    ],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "⛔ This field is required";
                                      }
                                      return null;
                                    },
                                    onChanged: (newValue) {
                                      setState(() {
                                        cardNumberEditingController.text =
                                            newValue;
                                        cardNumberEditingController.selection =
                                            TextSelection.fromPosition(
                                                TextPosition(
                                                    offset:
                                                        cardNumberEditingController
                                                            .text.length));
                                      });
                                    },
                                    onTap: () {
                                      setState(() {});
                                    },
                                    cursorColor:
                                        Theme.of(context).highlightColor,
                                    textInputAction: TextInputAction.next,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(12),
                                      color: const Color(0XFF131C24),
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText: 'XXXX XXXX XXXX XXXX',
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(12),
                                        color: Theme.of(context).disabledColor,
                                      ),
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.start,
                                      prefixIcon: Icon(
                                          BootstrapIcons.credit_card_2_front,
                                          size: ScreenUtil().setSp(16)),
                                      prefixIconColor:
                                          Theme.of(context).primaryColor,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          10.0, 0.0, 10.0, 0.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0XFFD4D5D4),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0XFFD4D5D4),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0XFFD4D5D4),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.022,
                                      MediaQuery.of(context).size.height *
                                          0.028,
                                      0.0,
                                      MediaQuery.of(context).size.height *
                                          0.008),
                                  child: Text(
                                    'Cardholder Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: ScreenUtil().setSp(11),
                                      color: const Color(0XFF131C24),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.052,
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: cardholderNameEditingController,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "⛔ This field is required";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        cardholderNameEditingController.text =
                                            value;
                                        cardholderNameEditingController
                                                .selection =
                                            TextSelection.fromPosition(
                                                TextPosition(
                                          offset:
                                              cardholderNameEditingController
                                                  .text.length,
                                        ));
                                      });
                                    },
                                    onTap: () {
                                      setState(() {});
                                    },
                                    cursorColor:
                                        Theme.of(context).highlightColor,
                                    textInputAction: TextInputAction.next,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(12),
                                      color: const Color(0XFF131C24),
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText: 'Cardholder Name',
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(12),
                                        color: Theme.of(context).disabledColor,
                                      ),
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.start,
                                      prefixIcon: Icon(
                                        BootstrapIcons.person,
                                        size: ScreenUtil().setSp(17),
                                      ),
                                      prefixIconColor:
                                          Theme.of(context).primaryColor,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          10.0, 0.0, 10.0, 0.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0XFFD4D5D4)),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0XFFD4D5D4)),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0XFFD4D5D4)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.fromLTRB(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.022,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.028,
                                              0.0,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.008),
                                          child: Text(
                                            'CVV',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: ScreenUtil().setSp(11),
                                              color: const Color(0XFF131C24),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.36,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.052,
                                          child: TextFormField(
                                            autofocus: false,
                                            controller: cvvEditingController,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  3),
                                            ],
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "⛔ This field is required";
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                cvvEditingController.text =
                                                    value;
                                                cvvEditingController.selection =
                                                    TextSelection.fromPosition(
                                                        TextPosition(
                                                            offset:
                                                                cvvEditingController
                                                                    .text
                                                                    .length));
                                              });
                                            },
                                            onTap: () {
                                              setState(() {});
                                            },
                                            cursorColor: Theme.of(context)
                                                .highlightColor,
                                            textInputAction:
                                                TextInputAction.next,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: ScreenUtil().setSp(12),
                                              color: const Color(0XFF131C24),
                                            ),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              hintText: 'CVV',
                                              hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                                color: Theme.of(context)
                                                    .disabledColor,
                                              ),
                                              floatingLabelAlignment:
                                                  FloatingLabelAlignment.start,
                                              prefixIcon: Icon(
                                                BootstrapIcons.credit_card,
                                                size: ScreenUtil().setSp(16),
                                              ),
                                              prefixIconColor: Theme.of(context)
                                                  .primaryColor,
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      10.0, 0.0, 10.0, 0.0),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0XFFD4D5D4)),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0XFFD4D5D4)),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0XFFD4D5D4)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.fromLTRB(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.022,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.028,
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.025,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.008),
                                          child: Text(
                                            'Expiration Date',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: ScreenUtil().setSp(11),
                                              color: const Color(0XFF131C24),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.36,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.052,
                                          child: TextFormField(
                                            autofocus: false,
                                            controller:
                                                expirationDateEditingController,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  4),
                                              CardExpirationFormatter(),
                                            ],
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "⛔ This field is required";
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                expirationDateEditingController
                                                    .text = value;
                                                expirationDateEditingController
                                                        .selection =
                                                    TextSelection.fromPosition(
                                                        TextPosition(
                                                            offset:
                                                                expirationDateEditingController
                                                                    .text
                                                                    .length));
                                              });
                                            },
                                            onTap: () {
                                              setState(() {
                                                expirationDateEditingController
                                                    .text;
                                              });
                                            },
                                            cursorColor: Theme.of(context)
                                                .highlightColor,
                                            textInputAction:
                                                TextInputAction.next,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: ScreenUtil().setSp(12),
                                              color: const Color(0XFF131C24),
                                            ),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              hintText: 'MM/YY',
                                              hintStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                                color: Theme.of(context)
                                                    .disabledColor,
                                              ),
                                              floatingLabelAlignment:
                                                  FloatingLabelAlignment.start,
                                              prefixIcon: Icon(
                                                  BootstrapIcons.calendar_event,
                                                  size: ScreenUtil().setSp(16)),
                                              prefixIconColor: Theme.of(context)
                                                  .primaryColor,
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      10.0, 0.0, 10.0, 0.0),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0XFFD4D5D4)),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0XFFD4D5D4)),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0XFFD4D5D4)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.022,
                                      MediaQuery.of(context).size.height *
                                          0.028,
                                      0.0,
                                      0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Save credit card',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(12),
                                          color: const Color(0XFF131C24),
                                        ),
                                      ),
                                      Switch(
                                        value: saveCreditCard,
                                        onChanged: (bool value) {
                                          setState(() {
                                            saveCreditCard = value;
                                          });
                                        },
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0.0,
                                      MediaQuery.of(context).size.height *
                                          0.022,
                                      0.0,
                                      MediaQuery.of(context).size.height *
                                          0.022),
                                  width:
                                      MediaQuery.of(context).size.width * 0.68,
                                  height: MediaQuery.of(context).size.height *
                                      0.048,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        //creditCardValue = value!;
                                        Navigator.pop(context);
                                        isClosedBottomSheet = true;
                                        //onPaymentOptionChanged(value);
                                        //savedCardNumberEditingController.text = creditCardNumbers[value];
                                        Navigator.of(
                                                _alertDialog as BuildContext)
                                            .pop();
                                        Payment(timeAndKm, price)
                                            .showPaymentScreen(context);
                                      });
                                    },
                                    child: changeCardLoading
                                        ? SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.032,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.032,
                                            child:
                                                const CircularProgressIndicator(
                                              color: Color(0XFFFFFDFA),
                                              strokeWidth: 2.0,
                                            ),
                                          )
                                        : const Text(
                                            'Add Card',
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container()
                  ],
                ));
          },
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(36.0),
          bottom: Radius.zero,
        ),
      ),
    );
  }
}

class CardExpirationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueString = newValue.text;
    String valueToReturn = '';

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != '/') valueToReturn += newValueString[i];
      var nonZeroIndex = i + 1;
      final contains = valueToReturn.contains(RegExp(r'\/'));
      if (nonZeroIndex % 2 == 0 &&
          nonZeroIndex != newValueString.length &&
          !(contains)) {
        valueToReturn += '/';
      }
    }
    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueString = newValue.text;
    String valueToReturn = '';

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != ' ') valueToReturn += newValueString[i];
      var nonZeroIndex = i + 1;
      final contains = valueToReturn.contains(RegExp(r'\/'));
      if (nonZeroIndex % 4 == 0 &&
          nonZeroIndex != newValueString.length &&
          !(contains)) {
        valueToReturn += ' ';
      }
    }
    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}
