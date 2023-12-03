import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';

class HRMSWhiteRoundedButton extends StatefulWidget {
  final String? text;
  final Function()? action;
  final bool? fullWidth;
  final Widget? child;
  const HRMSWhiteRoundedButton(
      {super.key, this.text, this.action, this.fullWidth, this.child});

  @override
  State<HRMSWhiteRoundedButton> createState() => _HRMSWhiteRoundedButtonState();
}

class _HRMSWhiteRoundedButtonState extends State<HRMSWhiteRoundedButton> {
  AppColors ac = AppColors();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: widget.fullWidth == null ? 270.0 : double.infinity,
      child: ElevatedButton(
        onPressed: widget.action,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(30.0), // Adjust border radius as needed
              side: BorderSide(
                width: 2.0,
                color:
                    Colors.blue[600]!, // Add blue[600] color as button border
              ),
            ),
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
