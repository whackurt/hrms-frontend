import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/features/health_record/screens/patient_record/patient_info_screen.dart';

class HRMSPatientListCard extends StatefulWidget {
  final Map? patientInfo;
  const HRMSPatientListCard({super.key, this.patientInfo});

  @override
  State<HRMSPatientListCard> createState() => _HRMSPatientListCardState();
}

class _HRMSPatientListCardState extends State<HRMSPatientListCard> {
  var appColor = AppColors().headingColor();
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 30.0,
                  color: AppColors().headingColor(),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width) * .60,
                  child: Text(
                    '${widget.patientInfo!['lastName']}, ${widget.patientInfo!['firstName']}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: appColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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
                            return const HRMSPatientInfoScreen();
                          },
                          settings:
                              RouteSettings(arguments: widget.patientInfo!)));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
