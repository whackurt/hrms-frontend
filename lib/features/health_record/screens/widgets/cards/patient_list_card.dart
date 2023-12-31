import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/features/health_record/controllers/patient.controller.dart';
import 'package:hrms_frontend/features/health_record/providers/patient.provider.dart';
import 'package:hrms_frontend/features/health_record/screens/patient_record/patient_info_screen.dart';
import 'package:provider/provider.dart';

class HRMSPatientListCard extends StatefulWidget {
  final Map? patientInfo;
  const HRMSPatientListCard({super.key, this.patientInfo});

  @override
  State<HRMSPatientListCard> createState() => _HRMSPatientListCardState();
}

class _HRMSPatientListCardState extends State<HRMSPatientListCard> {
  var appColor = AppColors().headingColor();
  bool deleteSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
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
                      width: (MediaQuery.of(context).size.width) * .50,
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
                                  settings: RouteSettings(
                                      arguments: widget.patientInfo!)));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Confirm Deletion',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    content: const Text(
                        'Are you sure you want to delete this patient?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await PatientController()
                              .deletePatient(
                                  patientId: widget.patientInfo!['_id'])
                              .then((res) {
                            if (res['success']) {
                              setState(() {
                                deleteSuccess = true;
                              });
                            }
                          });

                          if (deleteSuccess) {
                            await PatientController().getPatients().then((res) {
                              if (res['success']) {
                                context
                                    .read<PatientProvider>()
                                    .setPatientList(data: res['data']['data']);
                                setState(() {
                                  deleteSuccess = false;
                                });
                              }
                            });
                          }

                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.red[800]),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                Icons.delete,
                color: Colors.red[500],
              ),
            ),
          )
        ],
      ),
    );
  }
}
