import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/text_styles.dart';

class HRMSPatientPerZoneCard extends StatefulWidget {
  final int? numPatients;
  final int? zoneNum;
  final String? zoneName;
  const HRMSPatientPerZoneCard(
      {super.key, this.numPatients, this.zoneName, this.zoneNum});

  @override
  State<HRMSPatientPerZoneCard> createState() => _HRMSPatientPerZoneCardState();
}

class _HRMSPatientPerZoneCardState extends State<HRMSPatientPerZoneCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        height: 60.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          // boxShadow: const [
          //   BoxShadow(
          //     color: Colors.grey, // Shadow color
          //     blurRadius: 5, // Spread of the shadow
          //     offset: Offset(0, 3), // Offset in the X and Y direction
          //   ),
          // ]
          // border: Border.all(width: 1.0, color: Colors.grey)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Zone ${widget.zoneNum} - ${widget.zoneName}'.toUpperCase(),
              style: descriptionTextStyle(),
            ),
            const SizedBox(height: 5.0),
            Text('${widget.numPatients}', style: dashboardNumbers()),
          ],
        ),
      ),
    );
  }
}
