import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/features/health_record/screens/add_record/add_record_screen.dart';
import 'package:hrms_frontend/features/health_record/screens/dashboard/dashboard_screen.dart';
import 'package:hrms_frontend/features/health_record/screens/patient_record/patient_records_screen.dart';

class HRMSMainScreen extends StatefulWidget {
  const HRMSMainScreen({super.key});

  @override
  State<HRMSMainScreen> createState() => _HRMSMainScreenState();
}

class _HRMSMainScreenState extends State<HRMSMainScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
            // backgroundColor: AppColors().mainColor(),
            // inactiveColor: Colors.grey,
            border:
                const Border(top: BorderSide(width: 1.0, color: Colors.grey)),
            activeColor: AppColors().mainColor(),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
              ),
            ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (context) {
                  return const CupertinoPageScaffold(child: HRMSDashboard());
                },
              );

            case 1:
              return CupertinoTabView(
                builder: (context) {
                  return const CupertinoPageScaffold(
                      child: HRMSPatientRecordsScreen());
                },
              );

            case 2:
              return CupertinoTabView(
                builder: (context) {
                  return const CupertinoPageScaffold(
                      child: HRMSAddPatientScreen());
                },
              );
          }
          return Container();
        });
  }
}
