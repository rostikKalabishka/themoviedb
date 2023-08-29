import 'package:flutter/material.dart';

import 'package:themoviedb/ui/routes/routes.dart';

import 'ui/Theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: mainNavigation.onGenerateRoute,
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute(false),
      title: 'Flutter Demo',
      theme: theme,
      // home: AuthWidget(),
    );
  }
}
