import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';

class HRMSRedRoundedButton extends StatefulWidget {
  final String? text;
  final Function()? action;
  final bool? fullWidth;
  final Widget? child;
  const HRMSRedRoundedButton(
      {super.key, this.text, this.action, this.fullWidth, this.child});

  @override
  State<HRMSRedRoundedButton> createState() => _HRMSRedRoundedButtonState();
}

class _HRMSRedRoundedButtonState extends State<HRMSRedRoundedButton> {
  AppColors ac = AppColors();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: 40.0,
        width: widget.fullWidth == null ? 270.0 : double.infinity,
        child: ElevatedButton(
          onPressed: widget.action,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[400],
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(30.0), // Adjust border radius as needed
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
