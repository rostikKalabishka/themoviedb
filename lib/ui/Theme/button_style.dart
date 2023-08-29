import 'package:flutter/material.dart';

abstract class AppButtonStyle {
  static const color = Color(0xFF01B4e4);
  static final ButtonStyle linkButton = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(Colors.blue),
  );
  static final ButtonStyle eventButton = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(color),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      minimumSize: MaterialStateProperty.all(const Size(80, 30)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ));
}
