import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:spark_app/forgotPasswordPage.dart';
import 'package:spark_app/homePage.dart';
import 'package:spark_app/signUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.62,
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
                          bottom: MediaQuery.of(context).size.height * 0.016),
                      child: Text(
                        'Login to your account',
                        style: TextStyle(
                          color: const Color(0XFF131C24),
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(16),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0,
                          MediaQuery.of(context).size.height * 0.016, 0.0, 0.0),
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
                                  right: MediaQuery.of(context).size.width *
                                      0.012),
                              child: SvgPicture.asset(
                                'assets/images/google.svg',
                                width: MediaQuery.of(context).size.width * 0.04,
                                height:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width *
                                      0.012),
                              child: Text(
                                'Login with Google',
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
                      margin: EdgeInsets.fromLTRB(0.0,
                          MediaQuery.of(context).size.height * 0.016, 0.0, 0.0),
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
                                  right: MediaQuery.of(context).size.width *
                                      0.012),
                              child: SvgPicture.asset(
                                'assets/images/apple.svg',
                                width: MediaQuery.of(context).size.width * 0.04,
                                height:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width *
                                      0.012),
                              child: Text(
                                'Login with Apple',
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
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.04,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.03),
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
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.04,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.03),
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
                            paste: true,
                            cut: true,
                            selectAll: true,
                            copy: true),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.076,
                              0.0,
                              0.0,
                              MediaQuery.of(context).size.height * 0.002),
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
                          margin: EdgeInsets.fromLTRB(
                              0.0,
                              0.0,
                              MediaQuery.of(context).size.width * 0.036,
                              MediaQuery.of(context).size.height * 0.002),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.028,
                            child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  Get.to(const ForgotPasswordPage(),
                                      duration:
                                          const Duration(milliseconds: 200),
                                      transition: Transition.fadeIn);
                                });
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: const Color(0XFFA65969),
                                  fontWeight: FontWeight.w600,
                                  fontSize: ScreenUtil().setSp(9),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width * 0.68,
                      height: MediaQuery.of(context).size.height * 0.048,
                      child: TextFormField(
                        enableInteractiveSelection: true,
                        autofocus: false,
                        controller: passwordEditingController,
                        keyboardType: TextInputType.text,
                        toolbarOptions: const ToolbarOptions(
                            paste: true,
                            cut: true,
                            selectAll: true,
                            copy: true),
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
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0,
                          MediaQuery.of(context).size.height * 0.022, 0.0, 0.0),
                      width: MediaQuery.of(context).size.width * 0.68,
                      height: MediaQuery.of(context).size.height * 0.051,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Get.offAll(const HomePage());
                          });
                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.004),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(10.5),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          Get.to(const SignUpPage(),
                              duration: const Duration(milliseconds: 200),
                              transition: Transition.fadeIn);
                        });
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),
                      ),
                      child: Text('Create Account',
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
          ),
        ),
      ),
    );
  }
}
