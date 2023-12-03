import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/app_icon.dart';
import 'package:hrms_frontend/features/auth/controllers/auth.controller.dart';
import 'package:hrms_frontend/features/auth/models/admin.model.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/content_wrapper.dart';
import 'package:hrms_frontend/features/hw_account_mngt/screens/create_healthworker_screen.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';
import 'package:hrms_frontend/widgets/buttons/rounded_btn.dart';
import 'package:hrms_frontend/widgets/text/app_text.dart';
import 'package:hrms_frontend/widgets/text_field/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HRMSAdminLoginScreen extends StatefulWidget {
  const HRMSAdminLoginScreen({super.key});

  @override
  State<HRMSAdminLoginScreen> createState() => _HRMSAdminLoginScreenState();
}

class _HRMSAdminLoginScreenState extends State<HRMSAdminLoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthController authController = AuthController();
  final _adminKey = GlobalKey<FormState>();

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
      body: HRMSContentWrapper(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 70.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    appIcon(),
                    HRMSText().AppTitle(),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Log In  as Admin',
                      style: TextStyle(
                          // fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: AppColors().mainColor()),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 70.0,
            ),
            Form(
              key: _adminKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HRMSRoundedTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    validator: (uname) =>
                        uname!.isEmpty ? 'Username is required.' : null,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  HRMSRoundedTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (password) =>
                        password!.isEmpty ? 'Password is required.' : null,
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
              height: 70.0,
            ),
            HRMSRoundedButton(
              action: () async {
                setState(() {
                  loading = true;
                  statusMsg = '';
                });
                SharedPreferences pref = await SharedPreferences.getInstance();

                await authController
                    .loginAdmin(Admin(
                        username: usernameController.text.toString(),
                        password: passwordController.text.toString()))
                    .then((res) {
                  if (res['success']) {
                    pref.setString('adminToken', res['data']['token']);
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const HRMSCreateHealthworkerScreen()),
                            (route) => false);
                  } else {
                    setState(() {
                      statusMsg = res['data']['message'];
                    });
                  }

                  setState(() {
                    loading = false;
                  });
                });
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
                          fontWeight:
                              FontWeight.w700), // Adjust text style as needed
                    ),
            )
          ],
        ),
      ),
    );
  }
}
