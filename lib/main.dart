import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:zero/screens/welcome.dart';

void main() {
  runApp(const ZeroChatApp());
}

final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
);

final ThemeData kDefaultTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
      .copyWith(secondary: Colors.orangeAccent[400]),
);

class ZeroChatApp extends StatelessWidget {
  const ZeroChatApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Zero',
        theme: defaultTargetPlatform == TargetPlatform.iOS
            ? kIOSTheme
            : kDefaultTheme,
        home: WelcomeScreen());
    // home: const ChatScreen());
  }
}
