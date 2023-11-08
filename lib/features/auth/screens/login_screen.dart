import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/app_icon.dart';
import 'package:hrms_frontend/features/auth/endpoints/auth_endpoints.dart';
import 'package:hrms_frontend/features/auth/services/auth.dart';
import 'package:hrms_frontend/features/health_record/main_screen.dart';
import 'package:hrms_frontend/widgets/buttons/rounded_btn.dart';
import 'package:hrms_frontend/widgets/text/app_text.dart';
import 'package:hrms_frontend/widgets/text_field/text_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController hwidController = TextEditingController();
TextEditingController passwordController = TextEditingController();

Future login({required String hwid, required String password}) async {
  var res = await http.post(
      Uri.parse("https://hrms-backend-yrn5.onrender.com/api/auth/login"),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
      body: <String, String>{
        'hwid': hwid,
        'password': password
      });
  print(res.body);
}

class _LoginScreenState extends State<LoginScreen> {
  AppColors ac = AppColors();

  final Authentication auth = Authentication();
  Map<String, dynamic> res = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      appIcon(),
                      HRMSText().AppTitle(),
                      Text(
                        'Log In',
                        style: TextStyle(
                            // fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                            color: ac.mainColor()),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HRMSRoundedTextField(
                        controller: hwidController,
                        hintText: 'Healthworker ID',
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      HRMSRoundedTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80.0,
                  ),
                  Text('$res'),
                  Column(
                    children: [
                      // Container(
                      //   height: 40.0,
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //     onPressed: () async {
                      //       print('login clicked');
                      //       var hwLogin = await auth.login(
                      //           // hwidController.text.toString(),
                      //           // passwordController.text.toString()
                      //           '080808',
                      //           'kurt123');

                      //       print(hwLogin);
                      //       print('hotdog');
                      //       auth.verifyAccess();
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: ac.mainColor(),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(
                      //             30.0), // Adjust border radius as needed
                      //       ),
                      //     ),
                      //     child: Text(
                      //       'Login',
                      //       style: const TextStyle(
                      //           fontSize: 18.0,
                      //           fontWeight: FontWeight
                      //               .w700), // Adjust text style as needed
                      //     ),
                      //   ),
                      // ),
                      HRMSRoundedButton(
                        text: 'Login',
                        action: () {
                          print('login clicke');
                          login(
                              hwid: hwidController.text.trim(),
                              password: passwordController.text.trim());
                        },
                        fullWidth: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(
                                    context, '/auth/signup');
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: ac.mainColor(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                              ))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
