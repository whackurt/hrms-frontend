import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';

TextStyle headingTextStyle() {
  return TextStyle(
      fontSize: 35.0, color: Colors.grey[800], fontWeight: FontWeight.w700);
}

TextStyle descriptionTextStyleWhite() {
  return const TextStyle(
    fontSize: 15.0,
    color: Color.fromARGB(255, 243, 243, 243),
  );
}

TextStyle dashboardNumbersWhite() {
  return const TextStyle(
      fontSize: 35.0,
      color: Color.fromARGB(255, 243, 243, 243),
      fontWeight: FontWeight.w700);
}

TextStyle descriptionTextStyle() {
  return TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
    color: AppColors().headingColor(),
  );
}

TextStyle dashboardNumbers() {
  return TextStyle(
      fontSize: 25.0,
      color: AppColors().mainColor(),
      fontWeight: FontWeight.w700);
}

TextStyle sectionHeader() {
  return TextStyle(
      fontSize: 25.0, color: Colors.grey[750], fontWeight: FontWeight.w600);
}
