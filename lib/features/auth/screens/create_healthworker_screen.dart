import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hrms_frontend/core/constants/screens/landing_screen.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/app_icon.dart';
import 'package:hrms_frontend/core/theme/text_styles.dart';
import 'package:hrms_frontend/features/auth/controllers/auth.controller.dart';
import 'package:hrms_frontend/features/auth/models/healthWorker.model.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/text_field/text_field.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';
import 'package:hrms_frontend/widgets/buttons/rounded_btn.dart';
import 'package:hrms_frontend/widgets/buttons/white_rounded_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HRMSCreateHealthworkerScreen extends StatefulWidget {
  const HRMSCreateHealthworkerScreen({super.key});

  @override
  State<HRMSCreateHealthworkerScreen> createState() =>
      _HRMSCreateHealthworkerScreenState();
}

class _HRMSCreateHealthworkerScreenState
    extends State<HRMSCreateHealthworkerScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController hwidController = TextEditingController();

  AppColors ac = AppColors();
  final AuthController auth = AuthController();
  final _signupKey = GlobalKey<FormState>();

  Map<String, dynamic> data = {};
  bool loading = false;
  bool success = false;
  String statusMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: HRMSAppBar(
            title: 'Admin',
          )),
      body: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.add_circle,
                            color: AppColors().mainColor(),
                            size: 50.0,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create a Healthworker',
                                style: sectionHeader(),
                                maxLines: 2,
                              ),
                              const Text('Please enter required information.')
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      appIcon(),
                    ],
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Form(
                    key: _signupKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HRMSTextField(
                          label: 'Complete Name',
                          hintText: 'Enter healthworker name',
                          controller: nameController,
                          validator: (name) =>
                              name!.isEmpty ? 'Name is required.' : null,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        HRMSTextField(
                          label: 'Healthworker ID',
                          controller: hwidController,
                          hintText: 'Enter healthworker ID',
                          validator: (hwid) => hwid!.isEmpty
                              ? 'Healthworker ID is required.'
                              : null,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        HRMSTextField(
                          label: 'Password',
                          controller: passwordController,
                          hintText: 'Enter password',
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
                      style: TextStyle(
                          color: success ? Colors.green[600] : Colors.red[600]),
                    ),
                  ),
                  Column(
                    children: [
                      HRMSRoundedButton(
                        action: () async {
                          if (_signupKey.currentState!.validate()) {
                            setState(() {
                              statusMsg = '';
                              loading = true;
                              success = false;
                            });

                            await auth
                                .createHealthworker(HealthWorker(
                                    healthWorkerId: hwidController.text.trim(),
                                    name: nameController.text.trim(),
                                    password: passwordController.text.trim()))
                                .then((res) {
                              // print(res);
                              if (res['success']) {
                                setState(() {
                                  data = res['data'];
                                  statusMsg = res['data']['message'];
                                  success = true;
                                  loading = false;
                                });
                              } else {
                                setState(() {
                                  statusMsg = res['data']['message'] ??
                                      'Healthworker ID is taken already.';
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
                                'Create Healthworker',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight
                                        .w700), // Adjust text style as needed
                              ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      HRMSWhiteRoundedButton(
                        action: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Confirm Log out',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                content: loading
                                    ? const SpinKitCircle(
                                        color: Colors.blue,
                                        size: 30.0,
                                      )
                                    : const Text(
                                        'Are you sure you want to log out?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the alert dialog
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      pref.clear();
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context, rootNavigator: true)
                                          .pushAndRemoveUntil(
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      const Landing()),
                                              (route) => false);
                                    },
                                    child: const Text(
                                      'Log out',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        fullWidth: true,
                        child: Text(
                          'Log out',
                          style: TextStyle(
                              color: ac.mainColor(),
                              fontSize: 18.0,
                              fontWeight: FontWeight
                                  .w700), // Adjust text style as needed
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
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
