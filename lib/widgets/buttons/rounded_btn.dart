import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';

class HRMSRoundedButton extends StatefulWidget {
  final String? text;
  final Function()? action;
  final bool? fullWidth;
  const HRMSRoundedButton({super.key, this.text, this.action, this.fullWidth});

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
        child: Text(
          '${widget.text}',
          style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700), // Adjust text style as needed
        ),
      ),
    );
  }
}
