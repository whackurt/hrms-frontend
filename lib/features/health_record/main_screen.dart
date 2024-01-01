import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/features/health_record/screens/add_record/add_record_screen.dart';
import 'package:hrms_frontend/features/health_record/screens/dashboard/dashboard_screen.dart';
import 'package:hrms_frontend/features/health_record/screens/patient_record/patient_records_screen.dart';

class HRMSMainScreen extends StatefulWidget {
  const HRMSMainScreen({Key? key}) : super(key: key);

  @override
  State<HRMSMainScreen> createState() => _HRMSMainScreenState();
}

class _HRMSMainScreenState extends State<HRMSMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HRMSDashboard(),
    const HRMSPatientRecordsScreen(),
    const HRMSAddPatientScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Patient Records',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add Patient',
          ),
        ],
        selectedItemColor: AppColors().mainColor(),
      ),
    );
  }
}
