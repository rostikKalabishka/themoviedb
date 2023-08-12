import 'package:flutter/material.dart';
import 'package:themoviedb/routes/routes.dart';
import 'package:themoviedb/widgets/auth/auth_widget.dart';

import 'Theme/thema.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      initialRoute: '/auth',
      title: 'Flutter Demo',
      theme: theme,
      // home: AuthWidget(),
    );
  }
}
