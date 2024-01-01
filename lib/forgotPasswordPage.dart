import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:spark_app/loginPage.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailEditingController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _fromKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.34,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0.0,
                        MediaQuery.of(context).size.height * 0.02,
                        0.0,
                        MediaQuery.of(context).size.height * 0.02),
                    width: MediaQuery.of(context).size.width * 0.135,
                    height: MediaQuery.of(context).size.width * 0.135,
                    child: SvgPicture.asset(
                      'assets/images/spark_app_logo.svg',
                      color: const Color(0XFF131C24),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.048),
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: const Color(0XFF131C24),
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.076,
                        0.0,
                        0.0,
                        MediaQuery.of(context).size.height * 0.008),
                    child: Text(
                      'Email Address',
                      style: TextStyle(
                        color: const Color(0XFF131C24),
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(10),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0,
                        MediaQuery.of(context).size.height * 0.02),
                    width: MediaQuery.of(context).size.width * 0.68,
                    height: MediaQuery.of(context).size.height * 0.048,
                    child: TextFormField(
                      enableInteractiveSelection: true,
                      autofocus: false,
                      controller: emailEditingController,
                      keyboardType: TextInputType.text,
                      toolbarOptions: const ToolbarOptions(
                          paste: true, cut: true, selectAll: true, copy: true),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "⛔ This field is required";
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "⛔ Please enter a valid email adress";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        emailEditingController.text = newValue!;
                      },
                      cursorColor: Theme.of(context).highlightColor,
                      textInputAction: TextInputAction.next,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        color: const Color(0XFF131C24),
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(10),
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.028,
                            0.0,
                            MediaQuery.of(context).size.width * 0.028,
                            0.0),
                        hintText: 'name@example.com',
                        hintStyle: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).disabledColor),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).disabledColor),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).disabledColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.68,
                    height: MediaQuery.of(context).size.height * 0.048,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          resetPassword();
                        });
                      },
                      child: const Text('Send Reset Link'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> isDocumentExists(
      String collectionPath, String documentId) async {
    try {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      DocumentReference documentReference =
          _firestore.collection(collectionPath).doc(documentId);
      DocumentSnapshot documentSnapshot = await documentReference.get();

      return documentSnapshot.exists;
    } catch (e) {
      print("Error checking document existence: $e");
      return false;
    }
  }

  void resetPassword() async {
    if (_fromKey.currentState!.validate()) {
      try {
        String collectionPath = "Users";
        final email = emailEditingController.text.trim();
        bool isExists = await isDocumentExists(collectionPath, email);

        if (isExists == false) {
          Fluttertoast.showToast(
            msg: "No user found with this email.",
            backgroundColor: Theme.of(context).primaryColorDark,
            textColor: const Color(0XFFFFFDFA),
            fontSize: 14.0,
          );
        } else {
          await _auth.sendPasswordResetEmail(
            email: emailEditingController.text,
          );
          Fluttertoast.showToast(
            msg: "Password reset email sent",
            backgroundColor: Theme.of(context).primaryColorDark,
            textColor: const Color(0XFFFFFDFA),
            fontSize: 14.0,
          );
          Get.off(const LoginPage());
        }
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
          msg: "Sorry, something went wrong",
          backgroundColor: Theme.of(context).primaryColorDark,
          textColor: const Color(0XFFFFFDFA),
          fontSize: 14.0,
        );
        print(e.message.toString());
      }
    }
  }
}
