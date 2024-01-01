import 'package:flutter/material.dart';

class UpdateDriverLicensePage extends StatefulWidget {
  const UpdateDriverLicensePage({super.key});

  @override
  State<UpdateDriverLicensePage> createState() => _UpdateDriverLicensePageState();
}

class _UpdateDriverLicensePageState extends State<UpdateDriverLicensePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Ehliyet güncelleme',
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