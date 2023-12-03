import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/app_icon.dart';
import 'package:hrms_frontend/features/auth/controllers/auth.controller.dart';
import 'package:hrms_frontend/features/auth/models/healthWorker.model.dart';
import 'package:hrms_frontend/widgets/buttons/rounded_btn.dart';
import 'package:hrms_frontend/widgets/text/app_text.dart';
import 'package:hrms_frontend/widgets/text_field/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController hwidController = TextEditingController();

class _SignUpScreenState extends State<SignUpScreen> {
  AppColors ac = AppColors();
  final AuthController auth = AuthController();
  final _signupKey = GlobalKey<FormState>();

  Map<String, dynamic> data = {};
  bool loading = false;
  String statusMsg = '';

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
                  Form(
                    key: _signupKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HRMSRoundedTextField(
                          hintText: 'Name',
                          controller: nameController,
                          validator: (name) =>
                              name!.isEmpty ? 'Name is required.' : null,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        HRMSRoundedTextField(
                          controller: hwidController,
                          hintText: 'Healthworker ID',
                          validator: (hwid) => hwid!.isEmpty
                              ? 'Healthworker ID is required.'
                              : null,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        HRMSRoundedTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                          validator: (password) => password!.isEmpty
                              ? 'Password is required.'
                              : null,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      statusMsg,
                      style: TextStyle(color: Colors.red[600]),
                    ),
                  ),
                  const SizedBox(
                    height: 80.0,
                  ),
                  Column(
                    children: [
                      HRMSRoundedButton(
                        action: () async {
                          if (_signupKey.currentState!.validate()) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            setState(() {
                              statusMsg = '';
                              loading = true;
                            });

                            await auth
                                .createHealthworker(HealthWorker(
                                    healthWorkerId: hwidController.text.trim(),
                                    name: nameController.text.trim(),
                                    password: passwordController.text.trim()))
                                .then((res) {
                              if (res['success']) {
                                setState(() {
                                  data = res['data'];
                                  loading = false;
                                });
                              } else {
                                setState(() {
                                  statusMsg = res['data']['message'];
                                  loading = false;
                                });
                              }
                            });

                            if (data['message'] ==
                                'Healthworker registered successfully.') {
                              await auth
                                  .loginHealthworker(HealthWorker(
                                      healthWorkerId: data['healthWorkerId'],
                                      name: '',
                                      password: passwordController.text.trim()))
                                  .then((res) {
                                if (res['success']) {
                                  setState(() {
                                    data = res['data'];
                                    loading = false;
                                  });

                                  prefs.setString('userId', data['userId']);
                                  prefs.setString('userName', data['userName']);
                                  prefs.setString('token', data['token']);

                                  nameController.clear();
                                  hwidController.clear();
                                  passwordController.clear();

                                  Navigator.popAndPushNamed(context, '/');
                                } else {
                                  setState(() {
                                    statusMsg = res['data']['message'];
                                    loading = false;
                                  });
                                }
                              });
                            }
                          }
                        },
                        fullWidth: true,
                        child: loading
                            ? const SpinKitCircle(
                                color: Colors.white,
                                size: 35.0,
                              )
                            : const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight
                                        .w700), // Adjust text style as needed
                              ),
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
