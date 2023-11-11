import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/app_icon.dart';
import 'package:hrms_frontend/widgets/text/app_text.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  final AppColors ac = AppColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 254),
      body: SafeArea(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Welcome to',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                            color: ac.mainColor()),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HRMSText().AppTitle(),
                          ])
                    ],
                  ),
                  appIcon(),
                  Column(
                    children: [
                      Container(
                        height: 40.0,
                        width: 270.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/auth/signup');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ac.mainColor(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30.0), // Adjust border radius as needed
                            ),
                          ),
                          child: const Text(
                            'Sign Up ',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight
                                    .w700), // Adjust text style as needed
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        height: 40.0,
                        width: 270.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/auth/login');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ac.mainColor(),
                            // padding: EdgeInsets.symmetric(
                            //     vertical: 10.0,
                            //     horizontal: 70.0), // Adjust padding as needed
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30.0), // Adjust border radius as needed
                            ),
                          ),
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight
                                    .w700), // Adjust text style as needed
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
