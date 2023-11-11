import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';

class HRMSRoundedButton extends StatefulWidget {
  final String? text;
  final Function()? action;
  final bool? fullWidth;
  final Widget? child;
  const HRMSRoundedButton(
      {super.key, this.text, this.action, this.fullWidth, this.child});

  @override
  State<HRMSRoundedButton> createState() => _HRMSRoundedButtonState();
}

class _HRMSRoundedButtonState extends State<HRMSRoundedButton> {
  AppColors ac = AppColors();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: widget.fullWidth == null ? 270.0 : double.infinity,
      child: ElevatedButton(
        onPressed: widget.action,
        style: ElevatedButton.styleFrom(
          backgroundColor: ac.mainColor(),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(30.0), // Adjust border radius as needed
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
