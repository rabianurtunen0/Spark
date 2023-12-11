import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:spark_app/loginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController fullNameEditingController =
      TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  bool isVisible = true;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _fromKey = GlobalKey<FormState>();
  //final GoogleSignIn _googleSignIn = GoogleSignIn();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    0.0,
                    MediaQuery.of(context).size.height * 0.1,
                    0.0,
                    MediaQuery.of(context).size.height * 0.04),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.04,
                          0.0,
                          MediaQuery.of(context).size.width * 0.02,
                          0.0),
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: 6,
                      decoration: BoxDecoration(
                        color: const Color(0XFF5982A6),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.02,
                          0.0,
                          MediaQuery.of(context).size.width * 0.02,
                          0.0),
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: 6,
                      decoration: BoxDecoration(
                        color: const Color(0XFFCFD1D4),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.02,
                          0.0,
                          MediaQuery.of(context).size.width * 0.02,
                          0.0),
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: 6,
                      decoration: BoxDecoration(
                        color: const Color(0XFFCFD1D4),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.02,
                          0.0,
                          MediaQuery.of(context).size.width * 0.04,
                          0.0),
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: 6,
                      decoration: BoxDecoration(
                        color: const Color(0XFFCFD1D4),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    )
                  ],
                ),
              ),
              signUp1(),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUp1() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.72,
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
                width: 60,
                height: 60,
                child: SvgPicture.asset(
                  'assets/images/spark_app_logo.svg',
                  color: const Color(0XFF131C24),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.016),
                child: Text(
                  'Sign up to your account',
                  style: TextStyle(
                    color: const Color(0XFF131C24),
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(16),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0.0, MediaQuery.of(context).size.height * 0.016, 0.0, 0.0),
                width: MediaQuery.of(context).size.width * 0.68,
                height: MediaQuery.of(context).size.height * 0.051,
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      //googleAccount();
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0XFFE5E7E9)),
                    overlayColor: MaterialStateProperty.all<Color>(
                        const Color(0XFFD7DBDF)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.012),
                        child: SvgPicture.asset(
                          'assets/images/google.svg',
                          width: MediaQuery.of(context).size.width * 0.04,
                          height: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.012),
                        child: Text(
                          'Sign up with Google',
                          style: TextStyle(
                            color: const Color(0XFF131C24),
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(10.5),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0.0, MediaQuery.of(context).size.height * 0.016, 0.0, 0.0),
                width: MediaQuery.of(context).size.width * 0.68,
                height: MediaQuery.of(context).size.height * 0.051,
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0XFFE5E7E9)),
                    overlayColor: MaterialStateProperty.all<Color>(
                        const Color(0XFFD7DBDF)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.012),
                        child: SvgPicture.asset(
                          'assets/images/apple.svg',
                          width: MediaQuery.of(context).size.width * 0.04,
                          height: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.012),
                        child: Text(
                          'Sign up with Apple',
                          style: TextStyle(
                            color: const Color(0XFF131C24),
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(10.5),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.04,
                          vertical: MediaQuery.of(context).size.height * 0.03),
                      child: const Divider(color: Color(0XFF131C24)),
                    ),
                  ),
                  Text(
                    'Or continue with',
                    style: TextStyle(
                      color: const Color(0XFF131C24),
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(10),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.04,
                          vertical: MediaQuery.of(context).size.height * 0.03),
                      child: const Divider(color: Color(0XFF131C24)),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.076,
                    0.0,
                    0.0,
                    MediaQuery.of(context).size.height * 0.008),
                child: Text(
                  'Full Name',
                  style: TextStyle(
                    color: const Color(0XFF131C24),
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(10),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(
                    0.0, 0.0, 0.0, MediaQuery.of(context).size.height * 0.02),
                width: MediaQuery.of(context).size.width * 0.68,
                height: MediaQuery.of(context).size.height * 0.048,
                child: TextFormField(
                  enableInteractiveSelection: true,
                  autofocus: false,
                  controller: fullNameEditingController,
                  keyboardType: TextInputType.text,
                  toolbarOptions: const ToolbarOptions(
                      paste: true, cut: true, selectAll: true, copy: true),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "⛔ This field is required";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    fullNameEditingController.text = newValue!;
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
                    hintText: 'Full Name',
                    hintStyle: TextStyle(
                      color: Theme.of(context).disabledColor,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).disabledColor),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).disabledColor),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).disabledColor),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                    ),
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
                margin: EdgeInsets.fromLTRB(
                    0.0, 0.0, 0.0, MediaQuery.of(context).size.height * 0.02),
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
                      borderSide:
                          BorderSide(color: Theme.of(context).disabledColor),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).disabledColor),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).disabledColor),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                    ),
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
                  'Password',
                  style: TextStyle(
                    color: const Color(0XFF131C24),
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(10),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(
                    0.0, 0.0, 0.0, MediaQuery.of(context).size.height * 0.02),
                width: MediaQuery.of(context).size.width * 0.68,
                height: MediaQuery.of(context).size.height * 0.048,
                child: TextFormField(
                  enableInteractiveSelection: true,
                  autofocus: false,
                  controller: passwordEditingController,
                  keyboardType: TextInputType.text,
                  toolbarOptions: const ToolbarOptions(
                      paste: true, cut: true, selectAll: true, copy: true),
                  obscureText: isVisible,
                  obscuringCharacter: '•',
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{8,}$');
                    if (value!.isEmpty) {
                      return "⛔ This field is required";
                    }
                    if (!regex.hasMatch(value)) {
                      return "⛔ Enter valid password(Minimum 8 characters)";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    passwordEditingController.text = newValue!;
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
                    hintText: '••••••••',
                    hintStyle: TextStyle(
                      color: Theme.of(context).disabledColor,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(10),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: Icon(
                        isVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: const Color(0XFF131C24),
                        size: 18.0,
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).disabledColor),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).disabledColor),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).disabledColor),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0.0, MediaQuery.of(context).size.height * 0.01, 0.0, 0.0),
                width: MediaQuery.of(context).size.width * 0.68,
                height: MediaQuery.of(context).size.height * 0.051,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      createAccount(emailEditingController.text,
                          passwordEditingController.text);
                    });
                  },
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.004),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(10.5),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    Get.to(const LoginPage(),
                        duration: const Duration(milliseconds: 200),
                        transition: Transition.fadeIn);
                  });
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
                child: Text('Login',
                    style: TextStyle(
                        color: const Color(0XFF2D4153),
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(10.5),
                        decoration: TextDecoration.underline)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget signUp2() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.68,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.0)),
    );
  }

  Widget signUp3() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.68,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.0)),
    );
  }

  Widget signUp4() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.68,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.0)),
    );
  }

  void createAccount(String email, String password) async {
    if (_fromKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async => {
                await _firestore.collection('Users').doc(email).set({
                  'fullname': fullNameEditingController.text,
                  'email': email,
                  'location': null,
                }),
                Fluttertoast.showToast(
                  msg: "Account created succesfully :) ",
                  backgroundColor: Theme.of(context).primaryColorDark,
                  textColor: const Color(0XFFFFFDFA),
                  fontSize: 14.0,
                ),
                Get.to(const LoginPage())
              })
          .catchError((e) {
        Fluttertoast.showToast(
          msg: e!.message,
          backgroundColor: Theme.of(context).primaryColorDark,
          textColor: const Color(0XFFFFFDFA),
          fontSize: 14.0,
        );
      });
    }
  }

  /*
  void googleAccount () async {

    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication?.idToken, accessToken: googleSignInAuthentication?.accessToken);
    UserCredential result = await _auth.signInWithCredential(authCredential);
    User? userDetails = result.user;
    print(userDetails!.displayName);
    print(userDetails.email);

    if(result != null) {
      _firestore.collection('Users').doc(userDetails!.email).set({
          'fullname': userDetails.displayName,
          'email': userDetails.email,
          'location': null,
      });
      Get.to(const LoginPage());
    }
  
  }

  void appleAccount () {

  }
*/
}
