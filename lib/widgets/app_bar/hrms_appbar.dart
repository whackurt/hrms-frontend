import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';

class HRMSAppBar extends StatefulWidget {
  final String? title;
  const HRMSAppBar({super.key, this.title});

  @override
  State<HRMSAppBar> createState() => _HRMSAppBarState();
}

class _HRMSAppBarState extends State<HRMSAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors().mainColor(),
      title: Text(
        '${widget.title}',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
    );
  }
}
