import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/app_icon.dart';
import 'package:hrms_frontend/features/health_record/main_screen.dart';
import 'package:hrms_frontend/widgets/buttons/rounded_btn.dart';
import 'package:hrms_frontend/widgets/text/app_text.dart';
import 'package:hrms_frontend/widgets/text_field/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AppColors ac = AppColors();

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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      appIcon(),
                      HRMSText().AppTitle(),
                      Text(
                        'Sign Up',
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
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HRMSRoundedTextField(
                        hintText: 'Name',
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      HRMSRoundedTextField(
                        hintText: 'Healthworker ID',
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      HRMSRoundedTextField(
                        hintText: 'Password',
                        obscureText: true,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80.0,
                  ),
                  Column(
                    children: [
                      HRMSRoundedButton(
                        text: 'Sign Up',
                        action: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) {
                            return const HRMSMainScreen();
                          }));
                        },
                        fullWidth: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already signed up?'),
                          TextButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(
                                    context, '/auth/login');
                              },
                              child: Text(
                                'Login',
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
