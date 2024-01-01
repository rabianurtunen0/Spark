import 'package:flutter/material.dart';

class MembershipAgreementPage extends StatefulWidget {
  const MembershipAgreementPage({super.key});

  @override
  State<MembershipAgreementPage> createState() => _MembershipAgreementPageState();
}

class _MembershipAgreementPageState extends State<MembershipAgreementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Üyelik Sözleşmesi',
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