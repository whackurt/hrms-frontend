import 'package:flutter/material.dart';

class HRMSPatientInfoText extends StatefulWidget {
  final String? label;
  final String? text;
  const HRMSPatientInfoText({super.key, this.label, this.text});

  @override
  State<HRMSPatientInfoText> createState() => _HRMSPatientInfoTextState();
}

class _HRMSPatientInfoTextState extends State<HRMSPatientInfoText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Text(
          '${widget.label}',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(
          height: 10.0,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .90,
          child: Text(
            '${widget.text}',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey[800],
                fontWeight: FontWeight.w600),
            maxLines: 2,
          ),
        ),
        const Divider(
          thickness: 1,
        )
      ],
    );
  }
}
