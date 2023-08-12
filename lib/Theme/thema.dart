import 'package:flutter/material.dart';

final theme = ThemeData(
  appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromRGBO(3, 37, 65, 1),
      iconTheme: IconThemeData(color: Colors.white)),
  textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.white)),
  useMaterial3: true,
);
