import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:spark_app/carRental/carRental.dart';
import 'package:spark_app/carRental/myAccountPage.dart';

class CardPage extends StatefulWidget {
  String cardNumber, cardholderName, cvv, expirationDate, email, fullName;

  CardPage(
      {Key? key,
      required this.cardNumber,
      required this.cardholderName,
      required this.cvv,
      required this.expirationDate,
      required this.email,
      required this.fullName})
      : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  BuildContext? _alertDialog;
  ScrollController _scrollController = ScrollController();
  late TextEditingController cardNumberEditingController;
  late TextEditingController cardholderNameEditingController;
  late TextEditingController cvvEditingController;
  late TextEditingController expirationDateEditingController;
  bool isCvvFocused = false;
  bool isLoading = false;
  bool isLoading2 = false;

  String email = "";
  String fullName = "";
  List cardsList = [];

  @override
  void initState() {
    super.initState();
    cardNumberEditingController =
        TextEditingController(text: widget.cardNumber);
    cardholderNameEditingController =
        TextEditingController(text: widget.cardholderName);
    cvvEditingController = TextEditingController(text: widget.cvv);
    expirationDateEditingController =
        TextEditingController(text: widget.expirationDate);
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
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.02,
                    MediaQuery.of(context).size.height * 0.01,
                    MediaQuery.of(context).size.width * 0.02,
                    MediaQuery.of(context).size.height * 0.01),
                child: CreditCardWidget(
                  cardNumber: cardNumberEditingController.text,
                  expiryDate: expirationDateEditingController.text,
                  cardHolderName: cardholderNameEditingController.text,
                  cvvCode: cvvEditingController.text,
                  showBackView: isCvvFocused,
                  isHolderNameVisible: true,
                  onCreditCardWidgetChange: (CreditCardBrand) {},
                  isChipVisible: true,
                  obscureCardCvv: false,
                  obscureCardNumber: false,
                  obscureInitialCardNumber: false,
                  cardBgColor: const Color(0XFF202E3B),
                  backCardBorder:
                      Border.all(width: 1, color: const Color(0XFF202E3B)),
                  frontCardBorder:
                      Border.all(width: 1, color: const Color(0XFF202E3B)),
                  textStyle: TextStyle(
                    color: const Color(0XFFA1A3B4),
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(13),
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.12,
                    MediaQuery.of(context).size.height * 0.028,
                    0.0,
                    MediaQuery.of(context).size.height * 0.008),
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
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.098),
                height: MediaQuery.of(context).size.height * 0.051,
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
                      cardNumberEditingController.text = newValue;
                      cardNumberEditingController.selection =
                          TextSelection.fromPosition(TextPosition(
                              offset: cardNumberEditingController.text.length));
                    });
                  },
                  onTap: () {
                    setState(() {
                      isCvvFocused = false;
                    });
                  },
                  cursorColor: Theme.of(context).highlightColor,
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
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'XXXX XXXX XXXX XXXX',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(12),
                      color: Theme.of(context).disabledColor,
                    ),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    prefixIcon: Icon(BootstrapIcons.credit_card_2_front,
                        size: ScreenUtil().setSp(16)),
                    prefixIconColor: Theme.of(context).primaryColor,
                    contentPadding:
                        const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0XFFD4D5D4),
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0XFFD4D5D4),
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0XFFD4D5D4),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.12,
                    MediaQuery.of(context).size.height * 0.028,
                    0.0,
                    MediaQuery.of(context).size.height * 0.008),
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
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.098),
                height: MediaQuery.of(context).size.height * 0.051,
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
                      cardholderNameEditingController.text = value;
                      cardholderNameEditingController.selection =
                          TextSelection.fromPosition(TextPosition(
                        offset: cardholderNameEditingController.text.length,
                      ));
                    });
                  },
                  onTap: () {
                    setState(() {
                      isCvvFocused = false;
                    });
                  },
                  cursorColor: Theme.of(context).highlightColor,
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
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Cardholder Name',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(12),
                      color: Theme.of(context).disabledColor,
                    ),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    prefixIcon: Icon(
                      BootstrapIcons.person,
                      size: ScreenUtil().setSp(17),
                    ),
                    prefixIconColor: Theme.of(context).primaryColor,
                    contentPadding:
                        const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0XFFD4D5D4)),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0XFFD4D5D4)),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFFD4D5D4)),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.12,
                            MediaQuery.of(context).size.height * 0.028,
                            0.0,
                            MediaQuery.of(context).size.height * 0.008),
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
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.098),
                        width: MediaQuery.of(context).size.width * 0.36,
                        height: MediaQuery.of(context).size.height * 0.051,
                        child: TextFormField(
                          autofocus: false,
                          controller: cvvEditingController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "⛔ This field is required";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              cvvEditingController.text = value;
                              cvvEditingController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset:
                                          cvvEditingController.text.length));
                            });
                          },
                          onTap: () {
                            setState(() {
                              isCvvFocused = true;
                            });
                          },
                          cursorColor: Theme.of(context).highlightColor,
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'CVV',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(12),
                              color: Theme.of(context).disabledColor,
                            ),
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            prefixIcon: Icon(
                              BootstrapIcons.credit_card,
                              size: ScreenUtil().setSp(16),
                            ),
                            prefixIconColor: Theme.of(context).primaryColor,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0XFFD4D5D4)),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0XFFD4D5D4)),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0XFFD4D5D4)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.028,
                            MediaQuery.of(context).size.height * 0.028,
                            0.0,
                            MediaQuery.of(context).size.height * 0.008),
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
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.098),
                        width: MediaQuery.of(context).size.width * 0.36,
                        height: MediaQuery.of(context).size.height * 0.051,
                        child: TextFormField(
                          autofocus: false,
                          controller: expirationDateEditingController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
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
                              expirationDateEditingController.text = value;
                              expirationDateEditingController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: expirationDateEditingController
                                          .text.length));
                            });
                          },
                          onTap: () {
                            setState(() {
                              isCvvFocused = false;
                            });
                          },
                          cursorColor: Theme.of(context).highlightColor,
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'MM/YY',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(12),
                              color: Theme.of(context).disabledColor,
                            ),
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            prefixIcon: Icon(BootstrapIcons.calendar_event,
                                size: ScreenUtil().setSp(16)),
                            prefixIconColor: Theme.of(context).primaryColor,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0XFFD4D5D4)),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0XFFD4D5D4)),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0XFFD4D5D4)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0.0,
                    MediaQuery.of(context).size.height * 0.048,
                    0.0,
                    MediaQuery.of(context).size.height * 0.018),
                width: MediaQuery.of(context).size.width * 0.78,
                height: MediaQuery.of(context).size.height * 0.051,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    Future.delayed(const Duration(seconds: 1), () async {
                      isLoading = false;
                      widget.cardNumber == ""
                          ? addCard(
                              cardNumberEditingController.text,
                              cardholderNameEditingController.text,
                              cvvEditingController.text,
                              expirationDateEditingController.text)
                          : changeCard(widget.cardNumber, widget.cardholderName,
                              widget.cvv, widget.expirationDate);

                      cardsList.clear();
                      var collection2 = FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser?.email)
                          .collection('Cards');
                      var querySnapshot = await collection2.get();
                      var list = querySnapshot.docs;
                      for (int i = 0; i < list.length; i++) {
                        cardsList.add(list[i].data());
                      }
                      print('Cards List: $cardsList');

                      Get.offAll(CarRental(selectedItemPosition: 1),
                          transition: Transition.rightToLeft);
                      Get.to(
                          MyAccountPage(
                              fullName: widget.fullName,
                              email: widget.email,
                              cardsList: cardsList),
                          transition: Transition.rightToLeft);
                    });
                  },
                  child: isLoading
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.032,
                          width: MediaQuery.of(context).size.height * 0.032,
                          child: const CircularProgressIndicator(
                            color: Color(0XFFFFFDFA),
                            strokeWidth: 2.0,
                          ),
                        )
                      : Text(
                          widget.cardNumber == "" ? 'Add Card' : "Change Card",
                        ),
                ),
              ),
              widget.cardNumber != ""
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.78,
                      height: MediaQuery.of(context).size.height * 0.051,
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            isLoading2 = true;
                          });
                          Future.delayed(const Duration(seconds: 1), () async {
                            isLoading2 = false;
                            deleteDocument(widget.cardNumber);

                            cardsList.clear();
                            var collection2 = FirebaseFirestore.instance
                                .collection('Users')
                                .doc(FirebaseAuth.instance.currentUser?.email)
                                .collection('Cards');
                            var querySnapshot = await collection2.get();
                            var list = querySnapshot.docs;
                            for (int i = 0; i < list.length; i++) {
                              cardsList.add(list[i].data());
                            }
                            print('Cards List: $cardsList');

                            Get.offAll(CarRental(selectedItemPosition: 1),
                                transition: Transition.rightToLeft);
                            Get.to(
                                MyAccountPage(
                                    fullName: widget.fullName,
                                    email: widget.email,
                                    cardsList: cardsList),
                                transition: Transition.rightToLeft);
                          });
                        },
                        child: isLoading2
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.032,
                                width:
                                    MediaQuery.of(context).size.height * 0.032,
                                child: const CircularProgressIndicator(
                                  color: Color(0XFFFFFDFA),
                                  strokeWidth: 2.0,
                                ),
                              )
                            : Text(
                                'Delete',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> changeCard(String cardNumber, String cardHolderName, String cvv,
      String expirationDate) async {
    try {
      var collection = FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection('Cards');

      var querySnapshot =
          await collection.where('cardNumber', isEqualTo: cardNumber).get();

      for (var document in querySnapshot.docs) {
        await document.reference.update({
          'cardNumber': cardNumberEditingController.text,
          'cardholderName': cardholderNameEditingController.text,
          'cvv': cvvEditingController.text,
          'expirationDate': expirationDateEditingController.text,
        });

        print('Document updated: ${document.id}');
      }

      print('Documents updated successfully.');

      Fluttertoast.showToast(
                msg: "Your card has been updated successfully.",
                backgroundColor: Theme.of(context).primaryColorDark,
                textColor: const Color(0XFFFFFDFA),
                fontSize: 14.0,
              );
    } catch (error) {
      print('Error updating documents: $error');
    }
  }

  Future<void> addCard(String cardNumber, String cardHolderName, String cvv,
      String expirationDate) async {
    try {
      var collection = FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection('Cards');

      await collection.add({
        'cardNumber': cardNumber,
        'cardholderName': cardHolderName,
        'cvv': cvv,
        'expirationDate': expirationDate,
      });

      Fluttertoast.showToast(
                msg: "Your card has been added successfully.",
                backgroundColor: Theme.of(context).primaryColorDark,
                textColor: const Color(0XFFFFFDFA),
                fontSize: 14.0,
              );

      print('Document added successfully.');
    } catch (error) {
      print('Error adding document: $error');
    }
  }

  Future<void> deleteDocument(String cardNumber) async {
    try {
      var collection = FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection('Cards');

      var querySnapshot =
          await collection.where('cardNumber', isEqualTo: cardNumber).get();

      for (var document in querySnapshot.docs) {
        await document.reference.delete();
        print('Document deleted: ${document.id}');
      }

      Fluttertoast.showToast(
        msg: "Your card has been updated successfully.",
        backgroundColor: Theme.of(context).primaryColorDark,
        textColor: const Color(0XFFFFFDFA),
        fontSize: 14.0,
      );

      print('Documents deleted successfully.');
    } catch (error) {
      print('Error deleting documents: $error');
    }
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
