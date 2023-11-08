import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/constants/screens/landing_screen.dart';
import 'package:hrms_frontend/features/auth/screens/login_screen.dart';
import 'package:hrms_frontend/features/auth/screens/signup_screen.dart';
import 'package:hrms_frontend/features/health_record/main_screen.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        fontFamily: 'ProximaNova',
      ),
      initialRoute: '/landing',
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
      }));
}
