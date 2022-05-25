import 'package:flutter/material.dart';
import 'messages.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:zero/amplifyconfiguration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    if (!Amplify.isConfigured) {
      _configureAmplify();
    }
  }

  void _configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.configure(amplifyconfig);
      print('Successfully configured');
    } on Exception catch (e) {
      print('Error configuring Amplify: $e');
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
          body: const MessagesPage(),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey.shade400,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.message), label: "Messages"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined), label: "Profile")
            ],
          ),
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
    primarySwatch: Colors.indigo,
  ),
  // tab bar indicator color
  indicatorColor: Colors.indigo,
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
        backgroundColor: MaterialStateProperty.all(Colors.purple.shade700)),
  ),
);
