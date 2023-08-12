import 'package:flutter/material.dart';

import '../../Theme/app_bar_style.dart';

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
      title: const Text(
        'Resend email',
        style: textAppBar,
      ),
    ));
  }
}
