import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';

class HRMSText {
  AppColors ac = AppColors();

  Widget AppTitle() {
    return Text(
      'Health Record\nManagement System',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.w700, fontSize: 30.0, color: ac.mainColor()),
    );
  }
}
