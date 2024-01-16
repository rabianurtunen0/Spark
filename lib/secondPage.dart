import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:spark_app/sparkHomePage.dart';
import 'package:spark_app/loginPage.dart';
import 'package:spark_app/signUpPage.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.08,
            MediaQuery.of(context).size.height * 0.42,
            MediaQuery.of(context).size.width * 0.08,
            0.0),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.128),
              width: MediaQuery.of(context).size.width * 0.185,
              height: MediaQuery.of(context).size.width * 0.185,
              child: SvgPicture.asset(
                'assets/images/spark_app_logo.svg',
                color: const Color(0XFF131C24),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.008),
              width: MediaQuery.of(context).size.width * 0.68,
              height: MediaQuery.of(context).size.height * 0.051,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    Get.to(const SignUpPage(),
                      duration: const Duration(milliseconds: 400),
                      transition: Transition.fadeIn);
                  });
                },
                child: const Text('Sign Up'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.008),
              width: MediaQuery.of(context).size.width * 0.68,
              height: MediaQuery.of(context).size.height * 0.051,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    Get.to(const LoginPage(),
                      duration: const Duration(milliseconds: 400),
                      transition: Transition.fadeIn);
                  });
                },
                child: const Text('Login'),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  Get.offAll(const SparkHomePage(),
                    duration: const Duration(milliseconds: 400),
                    transition: Transition.fadeIn);
                });
              },
              child: const Text('Continue withhout membership'),
            ),
          ],
        ),
      ),
    );
  }
}
