import 'package:flutter/material.dart';

class RentedCarPage extends StatefulWidget {
  const RentedCarPage({super.key});

  @override
  State<RentedCarPage> createState() => _RentedCarPageState();
}

class _RentedCarPageState extends State<RentedCarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Kiralanmış Araç',
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