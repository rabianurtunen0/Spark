import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:spark_app/carRental/cardPage.dart';
import 'package:spark_app/carRental/carRental.dart';
import 'package:spark_app/carRental/membershipAgreementPage.dart';
import 'package:spark_app/carRental/profilePage.dart';
import 'package:spark_app/carRental/updateDriverLicensePage.dart';

class MyAccountPage extends StatefulWidget {
  String fullName, email;
  List cardsList;

  MyAccountPage({
    Key? key,
    required this.fullName,
    required this.email,
    required this.cardsList,
  }) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late TextEditingController fullNameEditingController;
  late TextEditingController emailEditingController;
  final oldPasswordEditingController = TextEditingController();
  final newPasswordEditingController = TextEditingController();
  final newPasswordAgainEditingController = TextEditingController();
  final TextEditingController dataController = TextEditingController();

  bool personalInformation = false;
  bool payments = false;
  bool sharing = false;
  bool app = false;
  bool changePassword = false;
  bool oldPasswordVisible = true;
  bool newPasswordVisible = true;
  bool newPasswordAgainVisible = true;
  bool save = false;
  bool isLoading = false;
  String masked = "";
  List cardsList = [];

  String maskCardNumber(String cardNumber) {
    String formattedCardNumber = cardNumber.replaceAll(' ', '');
    String lastFourDigits =
        formattedCardNumber.substring(formattedCardNumber.length - 4);
    String maskedCardNumber = '**** **** **** ' + lastFourDigits;
    return maskedCardNumber;
  }

  Future<void> updateCardList() async {
    cardsList.clear();
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.email)
        .collection('Cards');
    var querySnapshot = await collection.get();
    var list = querySnapshot.docs;
    for (int i = 0; i < list.length; i++) {
      cardsList.add(list[i].data());
    }
    print('Cards List: $cardsList');
    widget.cardsList = cardsList;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fullNameEditingController = TextEditingController(text: widget.fullName);
    emailEditingController = TextEditingController(text: widget.email);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies called');
    if (ModalRoute.of(context)?.isCurrent == true) {
      print('Page is now visible, perform necessary actions.');
    }
    updateCardList();
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
        title: Text('My Account',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(14),
                letterSpacing: 1.0)),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0.0,
                      MediaQuery.of(context).size.height * 0.05,
                      0.0,
                      MediaQuery.of(context).size.height * 0.025),
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.02,
                      0.0,
                      MediaQuery.of(context).size.width * 0.02,
                      0.0),
                  width: MediaQuery.of(context).size.width * 0.86,
                  height: save
                      ? changePassword
                          ? MediaQuery.of(context).size.height * 0.46
                          : MediaQuery.of(context).size.height * 0.33
                      : MediaQuery.of(context).size.height * 0.246,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.02,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.04),
                        child: Text(
                          'Personal Informations',
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(12)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.036,
                                MediaQuery.of(context).size.height * 0.003,
                                0.0,
                                0.0),
                            alignment: Alignment.center,
                            child: Icon(
                              BootstrapIcons.person,
                              color: Theme.of(context).primaryColor,
                              size: ScreenUtil().setSp(17),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.66,
                            height: MediaQuery.of(context).size.height * 0.042,
                            margin: EdgeInsets.fromLTRB(
                                0.0,
                                MediaQuery.of(context).size.height * 0.012,
                                MediaQuery.of(context).size.width * 0.036,
                                MediaQuery.of(context).size.height * 0.006),
                            child: TextFormField(
                              autofocus: false,
                              controller: fullNameEditingController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "⛔ This field is required";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                fullNameEditingController.text = newValue!;
                              },
                              onTap: () {
                                setState(() {
                                  save = true;
                                });
                              },
                              cursorColor: Theme.of(context).highlightColor,
                              textInputAction: TextInputAction.next,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(12),
                                color: const Color(0XFF131C24),
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.03,
                                    0.0,
                                    MediaQuery.of(context).size.width * 0.03,
                                    0.0),
                                hintText: 'Full Name',
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(12),
                                    color: Theme.of(context).disabledColor),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0XFFD4D5D4)),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0XFFD4D5D4)),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XFFD4D5D4)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.042,
                                MediaQuery.of(context).size.height * 0.006,
                                MediaQuery.of(context).size.width * 0.012,
                                0.0),
                            alignment: Alignment.center,
                            child: Icon(
                              BootstrapIcons.envelope_at,
                              color: Theme.of(context).primaryColor,
                              size: ScreenUtil().setSp(15),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.66,
                            height: MediaQuery.of(context).size.height * 0.042,
                            margin: EdgeInsets.fromLTRB(
                                0.0,
                                MediaQuery.of(context).size.height * 0.015,
                                MediaQuery.of(context).size.width * 0.036,
                                MediaQuery.of(context).size.height * 0.006),
                            child: TextFormField(
                              autofocus: false,
                              controller: emailEditingController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "⛔ This field is required";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                emailEditingController.text = newValue!;
                                save = true;
                              },
                              onTap: () {
                                setState(() {
                                  save = true;
                                });
                              },
                              cursorColor: Theme.of(context).highlightColor,
                              textInputAction: TextInputAction.next,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(12),
                                color: const Color(0XFF131C24),
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                contentPadding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.03,
                                    0.0,
                                    MediaQuery.of(context).size.width * 0.03,
                                    0.0),
                                hintText: 'name@example.com',
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(12),
                                    color: Theme.of(context).disabledColor),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0XFFD4D5D4)),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0XFFD4D5D4)),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0XFFD4D5D4),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      changePassword == false
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.05,
                                      MediaQuery.of(context).size.height *
                                          0.0036,
                                      MediaQuery.of(context).size.width * 0.012,
                                      0.0),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    BootstrapIcons.lock,
                                    color: Theme.of(context).primaryColor,
                                    size: ScreenUtil().setSp(14),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height: MediaQuery.of(context).size.height *
                                      0.042,
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.018,
                                      MediaQuery.of(context).size.height *
                                          0.012,
                                      MediaQuery.of(context).size.width * 0.036,
                                      MediaQuery.of(context).size.height *
                                          0.006),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        changePassword = true;
                                        save = true;
                                      });
                                    },
                                    style: ButtonStyle(
                                      shadowColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.transparent),
                                      overlayColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.transparent),
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'CHANGE PASSWORD',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: ScreenUtil().setSp(11),
                                            color: Theme.of(context)
                                                .primaryColorLight),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      changePassword
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.048,
                                      MediaQuery.of(context).size.height *
                                          0.003,
                                      MediaQuery.of(context).size.width * 0.012,
                                      0.0),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    BootstrapIcons.lock,
                                    color: Theme.of(context).primaryColor,
                                    size: ScreenUtil().setSp(14),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.66,
                                  height: MediaQuery.of(context).size.height *
                                      0.042,
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.018,
                                      MediaQuery.of(context).size.height *
                                          0.015,
                                      MediaQuery.of(context).size.width * 0.036,
                                      MediaQuery.of(context).size.height *
                                          0.006),
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: oldPasswordEditingController,
                                    keyboardType: TextInputType.text,
                                    obscureText: oldPasswordVisible,
                                    obscuringCharacter: '•',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "⛔ This field is required";
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      oldPasswordEditingController.text =
                                          newValue!;
                                    },
                                    cursorColor:
                                        Theme.of(context).highlightColor,
                                    textInputAction: TextInputAction.next,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(12),
                                      color: const Color(0XFF131C24),
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      labelText: 'Old Password',
                                      labelStyle: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w600,
                                          fontSize: ScreenUtil().setSp(12),
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText: '••••••••',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(12),
                                          color:
                                              Theme.of(context).disabledColor),
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.start,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            oldPasswordVisible =
                                                !oldPasswordVisible;
                                          });
                                        },
                                        icon: Icon(
                                          oldPasswordVisible
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color: const Color(0XFF131C24)
                                              .withOpacity(0.6),
                                          size: ScreenUtil().setSp(15),
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                          0.0,
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                          0.0),
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
                            )
                          : Container(),
                      changePassword
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.048,
                                      MediaQuery.of(context).size.height *
                                          0.003,
                                      MediaQuery.of(context).size.width * 0.012,
                                      0.0),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    BootstrapIcons.lock,
                                    color: Theme.of(context).primaryColor,
                                    size: ScreenUtil().setSp(14),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.66,
                                  height: MediaQuery.of(context).size.height *
                                      0.042,
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.018,
                                      MediaQuery.of(context).size.height *
                                          0.015,
                                      MediaQuery.of(context).size.width * 0.036,
                                      MediaQuery.of(context).size.height *
                                          0.006),
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: newPasswordEditingController,
                                    keyboardType: TextInputType.text,
                                    obscureText: newPasswordVisible,
                                    obscuringCharacter: '•',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "⛔ This field is required";
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      newPasswordEditingController.text =
                                          newValue!;
                                    },
                                    cursorColor:
                                        Theme.of(context).highlightColor,
                                    textInputAction: TextInputAction.next,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(12),
                                      color: const Color(0XFF131C24),
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      labelText: 'New Password',
                                      labelStyle: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w600,
                                          fontSize: ScreenUtil().setSp(12),
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText: '••••••••',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(12),
                                          color:
                                              Theme.of(context).disabledColor),
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.start,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            newPasswordVisible =
                                                !newPasswordVisible;
                                          });
                                        },
                                        icon: Icon(
                                          newPasswordVisible
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color: const Color(0XFF131C24)
                                              .withOpacity(0.6),
                                          size: ScreenUtil().setSp(15),
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                          0.0,
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                          0.0),
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
                            )
                          : Container(),
                      changePassword
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.048,
                                      MediaQuery.of(context).size.height *
                                          0.003,
                                      MediaQuery.of(context).size.width * 0.012,
                                      0.0),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    BootstrapIcons.lock,
                                    color: Theme.of(context).primaryColor,
                                    size: ScreenUtil().setSp(14),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.66,
                                  height: MediaQuery.of(context).size.height *
                                      0.042,
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.018,
                                      MediaQuery.of(context).size.height *
                                          0.015,
                                      MediaQuery.of(context).size.width * 0.036,
                                      MediaQuery.of(context).size.height *
                                          0.006),
                                  child: TextFormField(
                                    autofocus: false,
                                    controller:
                                        newPasswordAgainEditingController,
                                    keyboardType: TextInputType.text,
                                    obscureText: newPasswordAgainVisible,
                                    obscuringCharacter: '•',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "⛔ This field is required";
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      newPasswordAgainEditingController.text =
                                          newValue!;
                                    },
                                    cursorColor:
                                        Theme.of(context).highlightColor,
                                    textInputAction: TextInputAction.next,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(12),
                                      color: const Color(0XFF131C24),
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      labelText: 'New Password',
                                      labelStyle: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w600,
                                          fontSize: ScreenUtil().setSp(12),
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText: '••••••••',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(12),
                                          color:
                                              Theme.of(context).disabledColor),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            newPasswordAgainVisible =
                                                !newPasswordAgainVisible;
                                          });
                                        },
                                        icon: Icon(
                                          newPasswordAgainVisible
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color: const Color(0XFF131C24)
                                              .withOpacity(0.6),
                                          size: ScreenUtil().setSp(15),
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                          0.0,
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                          0.0),
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
                            )
                          : Container(),
                      save
                          ? Container(
                              margin: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.08,
                                  MediaQuery.of(context).size.height * 0.02,
                                  0.0,
                                  MediaQuery.of(context).size.height * 0.02),
                              width: MediaQuery.of(context).size.width * 0.66,
                              height:
                                  MediaQuery.of(context).size.height * 0.046,
                              child: ElevatedButton(
                                onPressed: () {
                                  isLoading = true;
                                  Future.delayed(const Duration(seconds: 1),
                                      () async {
                                    isLoading = false;
                                    updateData();
                                    changePassword = false;
                                    save = false;
                                  });
                                  setState(() {});
                                },
                                child: isLoading
                                    ? SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.032,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.032,
                                        child: const CircularProgressIndicator(
                                          color: Color(0XFFFFFDFA),
                                          strokeWidth: 2.0,
                                        ),
                                      )
                                    : const Text(
                                        'Save',
                                      ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.025),
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.02,
                      0.0,
                      MediaQuery.of(context).size.width * 0.02,
                      0.0),
                  width: MediaQuery.of(context).size.width * 0.86,
                  height: MediaQuery.of(context).size.height * 0.12 +
                      widget.cardsList.length *
                          MediaQuery.of(context).size.height *
                          0.06,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.04,
                            MediaQuery.of(context).size.height * 0.01,
                            MediaQuery.of(context).size.width * 0.04,
                            MediaQuery.of(context).size.height * 0.01),
                        child: Text(
                          'Payment Methods',
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(12)),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.036),
                            height: widget.cardsList.length *
                                MediaQuery.of(context).size.height *
                                0.054,
                            child: ListView.builder(
                              itemCount: widget.cardsList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            MediaQuery.of(context).size.width *
                                                0.012,
                                            MediaQuery.of(context).size.height *
                                                0.003,
                                            0.0,
                                            0.0),
                                        alignment: Alignment.center,
                                        child: Icon(
                                          BootstrapIcons.credit_card_2_front,
                                          color: Theme.of(context).primaryColor,
                                          size: ScreenUtil().setSp(16),
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            Get.to(CardPage(
                                                cardNumber:
                                                    widget.cardsList[index]
                                                        ["cardNumber"],
                                                cardholderName:
                                                    widget.cardsList[index]
                                                        ['cardholderName'],
                                                cvv: widget.cardsList[index]
                                                    ['cvv'],
                                                expirationDate:
                                                    widget.cardsList[index]
                                                        ['expirationDate'],
                                                email: widget.email,
                                                fullName: widget.fullName));
                                          });
                                        },
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.008),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 0.3,
                                                      color: Theme.of(context)
                                                          .disabledColor))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.54,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                                margin: EdgeInsets.fromLTRB(
                                                    0.0,
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.004,
                                                    0.0,
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.002),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    maskCardNumber(
                                                        widget.cardsList[index]
                                                            ['cardNumber']),
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: ScreenUtil()
                                                          .setSp(11),
                                                      color: const Color(
                                                          0XFF131C24),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                BootstrapIcons.chevron_right,
                                                size: ScreenUtil().setSp(13),
                                                color: Color(0XFF131C24)
                                                    .withOpacity(0.8),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.058,
                                    MediaQuery.of(context).size.height * 0.004,
                                    MediaQuery.of(context).size.width * 0.018,
                                    0.0),
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.add_card,
                                  color: Theme.of(context).primaryColor,
                                  size: ScreenUtil().setSp(16),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.01,
                                    MediaQuery.of(context).size.height * 0.005,
                                    MediaQuery.of(context).size.width * 0.01,
                                    0.0),
                                child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      Get.to(CardPage(
                                          cardNumber: "",
                                          cardholderName: "",
                                          cvv: "",
                                          expirationDate: "",
                                          email: widget.email,
                                          fullName: widget.fullName));
                                    });
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Text(
                                    'ADD CARD',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(11),
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Get.to(const UpdateDriverLicensePage());
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.025),
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.02,
                          0.0,
                          MediaQuery.of(context).size.width * 0.02,
                          0.0),
                      width: MediaQuery.of(context).size.width * 0.86,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.05,
                                    MediaQuery.of(context).size.height * 0.003,
                                    MediaQuery.of(context).size.width * 0.024,
                                    0.0),
                                alignment: Alignment.center,
                                child: Icon(
                                  BootstrapIcons.person_vcard,
                                  color: Theme.of(context).primaryColor,
                                  size: ScreenUtil().setSp(15),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width * 0.56,
                                height:
                                    MediaQuery.of(context).size.height * 0.042,
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.02,
                                    MediaQuery.of(context).size.height * 0.009,
                                    MediaQuery.of(context).size.width * 0.036,
                                    MediaQuery.of(context).size.height * 0.006),
                                child: Text(
                                  "Update your driver's license",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: ScreenUtil().setSp(11),
                                      color: const Color(0XFF131C24)
                                          .withOpacity(0.8)),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * 0.04),
                            child: Icon(
                              BootstrapIcons.arrow_right,
                              size: ScreenUtil().setSp(13),
                              color: Color(0XFF131C24).withOpacity(0.8),
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Get.to(const MembershipAgreementPage());
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.025),
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.02,
                          0.0,
                          MediaQuery.of(context).size.width * 0.02,
                          0.0),
                      width: MediaQuery.of(context).size.width * 0.86,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.05,
                                    MediaQuery.of(context).size.height * 0.003,
                                    MediaQuery.of(context).size.width * 0.024,
                                    0.0),
                                alignment: Alignment.center,
                                child: Icon(
                                  BootstrapIcons.file_earmark_text,
                                  color: Theme.of(context).primaryColor,
                                  size: ScreenUtil().setSp(15),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width * 0.56,
                                height:
                                    MediaQuery.of(context).size.height * 0.042,
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.02,
                                    MediaQuery.of(context).size.height * 0.009,
                                    MediaQuery.of(context).size.width * 0.036,
                                    MediaQuery.of(context).size.height * 0.006),
                                child: Text(
                                  'Membership Agreement',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: ScreenUtil().setSp(11),
                                      color: const Color(0XFF131C24)
                                          .withOpacity(0.8)),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * 0.04),
                            child: Icon(
                              BootstrapIcons.arrow_right,
                              size: ScreenUtil().setSp(13),
                              color: Color(0XFF131C24).withOpacity(0.8),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateData() async {
    if (_formKey.currentState!.validate()) {


      final user = FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
          email: user!.email.toString(),
          password: oldPasswordEditingController.text);

      user.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPasswordEditingController.text).then((_) {
          Fluttertoast.showToast(
            msg: "Your information has been successfully changed",
            backgroundColor: Theme.of(context).primaryColorDark,
            textColor: const Color(0XFFFFFDFA),
            fontSize: 14.0,
          );
        }).catchError((error) {
          print("Error " + error.toString());
        });
      }).catchError((e) {
        Fluttertoast.showToast(
          msg: e.message,
          backgroundColor: Theme.of(context).primaryColorDark,
          textColor: const Color(0XFFFFFDFA),
          fontSize: 14.0,
        );
      });

      
      await _auth.currentUser!.updateEmail(emailEditingController.text);
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.email)
          .update({
        'email': emailEditingController.text,
        'fullname': fullNameEditingController.text,
      }).then((value) => {
                Fluttertoast.showToast(
                  msg: "Your information has been successfully changed",
                  backgroundColor: Theme.of(context).primaryColorDark,
                  textColor: const Color(0XFFFFFDFA),
                  fontSize: 14.0,
                ),
              });

      Get.offAll(CarRental(selectedItemPosition: 1));
    }
  }
}
