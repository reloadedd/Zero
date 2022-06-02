import 'package:flutter/material.dart';
import 'package:zero/screens/seed_phrase_generation.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:zero/amplifyconfiguration.dart';
import 'messages.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:zero/models/ModelProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zero/constants.dart';
import 'package:amplify_api/amplify_api.dart';

bool? APP_OPENED_FIRST_TIME;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _amplifyConfigured = false;

  void _initialSetup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final appOpenedFirstTime = prefs.getBool(G_APP_OPENEND_FIRST_TIME);
    APP_OPENED_FIRST_TIME = appOpenedFirstTime;
  }

  @override
  void initState() {
    super.initState();
    if (!Amplify.isConfigured) {
      _configureAmplify();
    }
    _initialSetup();
  }

  void _configureAmplify() async {
    // await Amplify.addPlugin(AmplifyAPI()); // UNCOMMENT this line after backend is deployed
    await Amplify.addPlugin(
        AmplifyDataStore(modelProvider: ModelProvider.instance));
    await Amplify.addPlugin(AmplifyAuthCognito());
    await Amplify.addPlugin(AmplifyAPI());

    // Once Plugins are added, configure Amplify
    await Amplify.configure(amplifyconfig);
    try {
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        title: 'Zero',
        theme: customLightTheme,
        themeMode: ThemeMode.light,
        builder: Authenticator.builder(),
        home: Scaffold(
          body: APP_OPENED_FIRST_TIME == true
              ? const SeedPhraseGenerationScreen()
              : const MessagesPage(),
        ),
      ),
    );
  }
}

// Light Theme - Credits: https://ui.docs.amplify.aws/flutter/components/authenticator
ThemeData customLightTheme = ThemeData(
  // app's colors scheme and brightness
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.light,
    primarySwatch: Colors.red,
  ),
  // tab bar indicator color
  indicatorColor: Colors.red,
  textTheme: const TextTheme(
    // text theme of the header on each step
    headline6: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 24,
    ),
  ),
  // theme of the form fields for each step
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(16),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: Colors.grey[200],
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
  // theme of the primary button for each step
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        padding:
            MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.red.shade400)),
  ),
);
