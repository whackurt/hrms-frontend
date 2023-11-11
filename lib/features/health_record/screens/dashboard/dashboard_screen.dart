import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hrms_frontend/core/theme/text_styles.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/features/auth/screens/login_screen.dart';
import 'package:hrms_frontend/features/health_record/widgets/cards/zone_num_patients.dart';
import 'package:hrms_frontend/features/health_record/widgets/content_wrapper.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';
import 'package:hrms_frontend/widgets/buttons/rounded_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HRMSDashboard extends StatefulWidget {
  const HRMSDashboard({super.key});

  @override
  State<HRMSDashboard> createState() => _HRMSDashboardState();
}

class _HRMSDashboardState extends State<HRMSDashboard> {
  List zoneNumber = [1, 2, 3, 4, 5, 6];
  List zoneName = ["Uno", "Dox", "Tres", "Kwatro", "Singko", "Sais"];
  List numPatients = [70, 30, 65, 15, 59, 14];

  bool loading = false;

  String? userName;

  void getHWName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName');
    });
  }

  @override
  void initState() {
    super.initState();
    getHWName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: HRMSAppBar(
            title: 'Dashboard',
          ),
        ),
        body: HRMSContentWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              Text('Hello, $userName!', style: headingTextStyle()),
              Text(
                'Welcome to Health Records Management System',
                style: TextStyle(fontSize: 15.0, color: Colors.grey[700]),
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                height: 90.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors().mainColor(),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('253', style: dashboardNumbersWhite()),
                            const SizedBox(height: 5.0),
                            Text(
                              'Total no. of Records'.toUpperCase(),
                              style: descriptionTextStyleWhite(),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.description_outlined,
                          size: 40.0,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              Text(
                'No. of Health Records',
                style: sectionHeader(),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1.0,
              ),
              const SizedBox(height: 5.0),
              HRMSPatientPerZoneCard(
                zoneName: zoneName[0],
                zoneNum: zoneNumber[0],
                numPatients: numPatients[0],
              ),
              HRMSPatientPerZoneCard(
                zoneName: zoneName[1],
                zoneNum: zoneNumber[1],
                numPatients: numPatients[1],
              ),
              HRMSPatientPerZoneCard(
                zoneName: zoneName[2],
                zoneNum: zoneNumber[2],
                numPatients: numPatients[2],
              ),
              HRMSPatientPerZoneCard(
                zoneName: zoneName[3],
                zoneNum: zoneNumber[3],
                numPatients: numPatients[3],
              ),
              HRMSPatientPerZoneCard(
                zoneName: zoneName[4],
                zoneNum: zoneNumber[4],
                numPatients: numPatients[4],
              ),
              HRMSPatientPerZoneCard(
                zoneName: zoneName[5],
                zoneNum: zoneNumber[5],
                numPatients: numPatients[5],
              ),
              const SizedBox(
                height: 8.0,
              ),
              HRMSRoundedButton(
                  fullWidth: true,
                  action: () {
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
                              : const Text('Are you sure you want to log out?'),
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
                                setState(() {
                                  loading = true;
                                });
                                pref.clear();

                                // ignore: use_build_context_synchronously
                                Navigator.of(context, rootNavigator: true)
                                    .pushAndRemoveUntil(
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()),
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
                  child: const Text(
                    'Log out',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  )),
              const SizedBox(height: 60.0),
            ],
          ),
        ));
  }
}
