import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/constants/screens/landing_screen.dart';
import 'package:hrms_frontend/features/auth/screens/login_screen.dart';
import 'package:hrms_frontend/features/auth/screens/signup_screen.dart';
import 'package:hrms_frontend/features/health_record/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool tokenPresent = await isTokenPresent();

  runApp(MyApp(tokenPresent: tokenPresent));
}

class MyApp extends StatelessWidget {
  final bool tokenPresent;

  const MyApp({super.key, required this.tokenPresent});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'ProximaNova',
        ),
        initialRoute: tokenPresent ? '/' : '/landing',
        home: const HRMSMainScreen(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return CupertinoPageRoute(
                  builder: (_) => const HRMSMainScreen(), settings: settings);
            case '/landing':
              return CupertinoPageRoute(
                  builder: (_) => Landing(), settings: settings);
            case '/auth/signup':
              return CupertinoPageRoute(
                  builder: (_) => const SignUpScreen(), settings: settings);
            case '/auth/login':
              return CupertinoPageRoute(
                  builder: (_) => const LoginScreen(), settings: settings);
          }
        });
  }
}

Future<bool> isTokenPresent() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token'); // Replace 'token' with your key

  return token != null && token.isNotEmpty;
}
