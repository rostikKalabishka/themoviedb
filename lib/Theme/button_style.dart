import 'package:flutter/material.dart';

abstract class AppButtonStyle {
  static final color = const Color(0xFF01B4e4);
  static final ButtonStyle linkButton = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(Colors.blue),
  );
}
