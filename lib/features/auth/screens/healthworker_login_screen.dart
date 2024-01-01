import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/app_icon.dart';
import 'package:hrms_frontend/features/auth/controllers/auth.controller.dart';
import 'package:hrms_frontend/features/auth/models/healthWorker.model.dart';
import 'package:hrms_frontend/features/health_record/main_screen.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';
import 'package:hrms_frontend/widgets/buttons/rounded_btn.dart';
import 'package:hrms_frontend/widgets/text/app_text.dart';
import 'package:hrms_frontend/widgets/text_field/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController hwidController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  AppColors ac = AppColors();
  final AuthController auth = AuthController();
  final _loginKey = GlobalKey<FormState>();

  Map<String, dynamic> data = {};
  bool loading = false;
  String statusMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: HRMSAppBar(
            title: '',
          )),
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
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Log in as Healthworker',
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
                    key: _loginKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                          setState(() {
                            statusMsg = '';
                          });
                          if (_loginKey.currentState!.validate()) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            setState(() {
                              loading = true;
                            });
                            await auth
                                .loginHealthworker(HealthWorker(
                                    healthWorkerId: hwidController.text.trim(),
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

                                hwidController.clear();
                                passwordController.clear();

                                Navigator.of(context, rootNavigator: true)
                                    .pushAndRemoveUntil(
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                const HRMSMainScreen()),
                                        (route) => false);
                              } else {
                                setState(() {
                                  statusMsg = res['data']['message'];
                                  loading = false;
                                });
                              }
                            });
                          }
                        },
                        fullWidth: true,
                        child: loading
                            ? const SpinKitCircle(
                                color: Colors.white,
                                size: 35.0,
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight
                                        .w700), // Adjust text style as needed
                              ),
                      ),
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
