import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Homeeeee',
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