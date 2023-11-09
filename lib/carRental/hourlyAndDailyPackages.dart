import 'package:flutter/material.dart';

class HourlyAndDailyPackagesPage extends StatefulWidget {
  const HourlyAndDailyPackagesPage({super.key});

  @override
  State<HourlyAndDailyPackagesPage> createState() => _HourlyAndDailyPackagesPageState();
}

class _HourlyAndDailyPackagesPageState extends State<HourlyAndDailyPackagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Detaylar....',
          style: TextStyle(
      color: Color(0XFF515856), 
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
      letterSpacing: 1.0,
    ),
        ),
      ),
    );
  }
}