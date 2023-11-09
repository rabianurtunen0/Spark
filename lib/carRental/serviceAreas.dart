import 'package:flutter/material.dart';

class ServiceAreasPage extends StatefulWidget {
  const ServiceAreasPage({super.key});

  @override
  State<ServiceAreasPage> createState() => _ServiceAreasPageState();
}

class _ServiceAreasPageState extends State<ServiceAreasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Hizmet Bölgeleri',
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