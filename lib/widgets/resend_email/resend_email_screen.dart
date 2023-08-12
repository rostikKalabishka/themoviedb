import 'package:flutter/material.dart';

class ResendEmailScreen extends StatefulWidget {
  const ResendEmailScreen({super.key});

  @override
  State<ResendEmailScreen> createState() => _ResendEmailScreenState();
}

class _ResendEmailScreenState extends State<ResendEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Resend email'),
    ));
  }
}
