import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/text_styles.dart';
import 'package:hrms_frontend/features/health_record/screens/patient_record/patient_list_screen.dart';

class HRMSPatientPerZoneCard extends StatefulWidget {
  final int? numPatients;
  final String? id;
  final int? zoneNum;
  const HRMSPatientPerZoneCard(
      {super.key, this.numPatients, this.zoneNum, this.id});

  @override
  State<HRMSPatientPerZoneCard> createState() => _HRMSPatientPerZoneCardState();
}

class _HRMSPatientPerZoneCardState extends State<HRMSPatientPerZoneCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) {
                  return const HRMSPatientListScreen();
                },
                settings: RouteSettings(arguments: {
                  "zoneId": widget.id,
                  "zoneNumber": widget.zoneNum
                })));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 60.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Zone ${widget.zoneNum}'.toUpperCase(),
                style: descriptionTextStyle(),
              ),
              const SizedBox(height: 5.0),
              Text('${widget.numPatients}', style: dashboardNumbers()),
            ],
          ),
        ),
      ),
    );
  }
}
