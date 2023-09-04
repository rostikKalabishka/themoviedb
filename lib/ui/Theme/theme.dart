import 'package:flutter/material.dart';

const color = Color(0xFF01B4e4);
final theme = ThemeData(
  appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromRGBO(3, 37, 65, 1),
      iconTheme: IconThemeData(color: Colors.white)),
  textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.white)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromRGBO(3, 37, 65, 1),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
  ),
  useMaterial3: true,
);

const textFormFieldStyle = InputDecoration(
  focusColor: color,
  border: OutlineInputBorder(),
  contentPadding: EdgeInsets.symmetric(horizontal: 10),
);
