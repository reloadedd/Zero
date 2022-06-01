import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zero/screens/home.dart';
import 'package:zero/screens/welcome.dart';
import 'constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

bool? appOpenedFirstTime;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  appOpenedFirstTime = prefs.getBool(G_APP_OPENEND_FIRST_TIME);
  if (appOpenedFirstTime == null) {
    prefs.setBool(G_APP_OPENEND_FIRST_TIME, true);
    appOpenedFirstTime = prefs.getBool(G_APP_OPENEND_FIRST_TIME);
  }

  print('appOpenedFirstTime: $appOpenedFirstTime');
  runApp(const ZeroChatApp());
}

class ZeroChatApp extends StatefulWidget {
  const ZeroChatApp({
    Key? key,
  }) : super(key: key);

  @override
  State<ZeroChatApp> createState() => _ZeroChatAppState();
}

class _ZeroChatAppState extends State<ZeroChatApp> {
  @override
  Widget build(BuildContext context) {
    return appOpenedFirstTime == true
        ? const MaterialApp(
            title: 'Zero', themeMode: ThemeMode.light, home: WelcomeScreen())
        : const MaterialApp(
            title: 'Zero', themeMode: ThemeMode.light, home: HomeScreen());
  }
}

final ThemeData kDefaultTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
      .copyWith(secondary: Colors.orangeAccent[400]),
);
