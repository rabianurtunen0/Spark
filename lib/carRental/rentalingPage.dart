import 'package:flutter/material.dart';

class RentalingPage extends StatefulWidget {
  const RentalingPage({super.key});

  @override
  State<RentalingPage> createState() => _RentalingPageState();
}

class _RentalingPageState extends State<RentalingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('kiralamaa'),
        ),
      ),
    );
  }
}