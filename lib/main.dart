import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/constants/screens/landing_screen.dart';
import 'package:hrms_frontend/features/auth/screens/admin_login_screen.dart';
import 'package:hrms_frontend/features/auth/screens/healthworker_login_screen.dart';
import 'package:hrms_frontend/features/health_record/main_screen.dart';
import 'package:hrms_frontend/features/health_record/providers/medicine.provider.dart';
import 'package:hrms_frontend/features/health_record/providers/patient.provider.dart';
import 'package:hrms_frontend/features/health_record/providers/zone.provider.dart';
import 'package:hrms_frontend/features/auth/screens/create_healthworker_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool tokenPresent = await isTokenPresent();
  final userType = await checkUser();

  runApp(MyApp(userType: userType, tokenPresent: tokenPresent));
}

Future<bool> isTokenPresent() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? adminToken = prefs.getString('adminToken');
  String? healthworkerToken = prefs.getString('token');
  String? token;

  if (adminToken != null) {
    token = adminToken;
  }
  if (healthworkerToken != null) {
    token = healthworkerToken;
  }

  return token != null && token.isNotEmpty;
}

Future<String> checkUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String user = '';
  String? adminToken = prefs.getString('adminToken');
  String? healthworkerToken = prefs.getString('token');

  if (adminToken != null) {
    user = 'admin';
  }

  if (healthworkerToken != null) {
    user = 'healthworker';
  }

  return user;
}

class MyApp extends StatelessWidget {
  final bool tokenPresent;
  final String userType;

  const MyApp({super.key, required this.tokenPresent, required this.userType});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PatientProvider()),
        ChangeNotifierProvider(create: (context) => ZoneProvider()),
        ChangeNotifierProvider(create: (context) => MedicineProvider()),
      ],
      child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'ProximaNova',
          ),
          initialRoute: tokenPresent && userType == 'admin'
              ? '/auth/healthworker/create'
              : tokenPresent && userType == 'healthworker'
                  ? '/'
                  : '/landing',
          home: const HRMSMainScreen(),
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/':
                return CupertinoPageRoute(
                    builder: (_) => const HRMSMainScreen(), settings: settings);
              case '/landing':
                return CupertinoPageRoute(
                    builder: (_) => const Landing(), settings: settings);
              case '/auth/admin/login':
                return CupertinoPageRoute(
                    builder: (_) => const HRMSAdminLoginScreen(),
                    settings: settings);
              // case '/auth/admin/login':
              //   return CupertinoPageRoute(
              //       builder: (_) => const HRMSAdminLoginScreen(),
              //       settings: settings);
              case '/auth/healthworker/create':
                return CupertinoPageRoute(
                    builder: (_) => const HRMSCreateHealthworkerScreen(),
                    settings: settings);
              case '/auth/login':
                return CupertinoPageRoute(
                    builder: (_) => const LoginScreen(), settings: settings);
            }
          }),
    );
  }
}
