import 'package:flutter/material.dart';

import 'package:themoviedb/ui/routes/routes.dart';

import 'main_model.dart';
import 'ui/Theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = MainModel();
  await model.checkAuth();
  runApp(MyApp(
    model: model,
  ));
}

class MyApp extends StatelessWidget {
  final MainModel model;
  static final mainNavigation = MainNavigation();
  const MyApp({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: mainNavigation.onGenerateRoute,
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute(model.isAuth),
      title: 'Flutter Demo',
      theme: theme,
      // home: AuthWidget(),
    );
  }
}
