import 'package:flutter/material.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';

import 'package:themoviedb/ui/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'main_model.dart';
import 'ui/Theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = MainModel();
  await model.checkAuth();
  const app = MyApp();

  final widget = Provider(
    model: model,
    child: app,
  );
  runApp(widget);
}

class MyApp extends StatelessWidget {
  // final MainModel model;
  static final mainNavigation = MainNavigation();
  const MyApp({
    super.key,
    // required this.model
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.read<MainModel>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ua', 'UA'),
      ],
      onGenerateRoute: mainNavigation.onGenerateRoute,
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute(model?.isAuth == true),
      title: 'Flutter Demo',
      theme: theme,
    );
  }
}
