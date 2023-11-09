import 'package:flutter/material.dart';

class PrivilegesPage extends StatefulWidget {
  const PrivilegesPage({super.key});

  @override
  State<PrivilegesPage> createState() => _PrivilegesPageState();
}

class _PrivilegesPageState extends State<PrivilegesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Ayrıcalıklar',
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