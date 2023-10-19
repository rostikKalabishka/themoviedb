import 'package:flutter/material.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';

import 'package:themoviedb/ui/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'ui/Theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const app = MyApp();

  runApp(app);
}

class MyApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
      initialRoute: MainNavigationRouteName.loaderScreen,
      title: 'Flutter Demo',
      theme: theme,
    );
  }
}
