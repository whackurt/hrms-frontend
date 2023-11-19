import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/features/health_record/screens/patient_record/patient_list_screen.dart';

class HRMSZoneCard extends StatefulWidget {
  final Map? zoneInfo;
  const HRMSZoneCard({super.key, this.zoneInfo});

  @override
  State<HRMSZoneCard> createState() => _HRMSZoneCardState();
}

class _HRMSZoneCardState extends State<HRMSZoneCard> {
  var appColor = AppColors().headingColor();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        width: double.infinity,
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          // border: Border.all(width: 1.0, color: Colors.grey
          // )
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.folder,
                    size: 30.0,
                    color: AppColors().headingColor(),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Text(
                    'Zone ${widget.zoneInfo!['zoneNumber']} - ${widget.zoneInfo!['zoneName']}',
                    style: TextStyle(
                        fontSize: 18.0,
                        // fontWeight: FontWeight.w600,
                        color: appColor),
                  ),
                ],
              ),
              Center(
                child: IconButton(
                  icon: Icon(
                    Icons.chevron_right,
                    size: 30.0,
                    color: appColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) {
                              return const HRMSPatientListScreen();
                            },
                            settings: RouteSettings(arguments: {
                              "zoneId": widget.zoneInfo!['_id'],
                              "zoneNumber": widget.zoneInfo!['zoneNumber']
                            })));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
