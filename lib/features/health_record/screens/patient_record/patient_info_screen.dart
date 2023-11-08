import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/text_styles.dart';
import 'package:hrms_frontend/features/health_record/screens/patient_record/medicine/medicines_screen.dart';
import 'package:hrms_frontend/features/health_record/screens/patient_record/update_patient_record_screen.dart';
import 'package:hrms_frontend/features/health_record/widgets/cards/patient_info_text.dart';
import 'package:hrms_frontend/features/health_record/widgets/content_wrapper.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';
import 'package:hrms_frontend/widgets/buttons/rounded_btn.dart';

class HRMSPatientInfoScreen extends StatefulWidget {
  const HRMSPatientInfoScreen({super.key});

  @override
  State<HRMSPatientInfoScreen> createState() => _HRMSPatientInfoScreenState();
}

DateTime? dateGiven;

class _HRMSPatientInfoScreenState extends State<HRMSPatientInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final patientData = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: HRMSAppBar(
              title: 'Health Record',
            )),
        body: HRMSContentWrapper(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: AppColors().mainColor(),
                        size: 50.0,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Patient Health Record',
                            style: sectionHeader(),
                          ),
                          // const Text('List of Patient Health Records')
                        ],
                      )
                    ],
                  ),
                  HRMSPatientInfoText(
                    label: 'Name',
                    text:
                        '${patientData['lastName']}, ${patientData['firstName']}',
                  ),
                  HRMSPatientInfoText(
                    label: 'Zone',
                    text: '${patientData['zone']}',
                  ),
                  HRMSPatientInfoText(
                    label: 'Street Address',
                    text: '${patientData['street']}',
                  ),
                  HRMSPatientInfoText(
                    label: 'Barangay',
                    text: '${patientData['brgy']}',
                  ),
                  HRMSPatientInfoText(
                    label: 'City/Municipality',
                    text: '${patientData['city_municipality']}',
                  ),
                  HRMSPatientInfoText(
                    label: 'Province',
                    text: '${patientData['province']}',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Medicines/Vaccinations Given',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18.0),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) {
                                    return const HRMSViewMedicines();
                                  },
                                  settings:
                                      RouteSettings(arguments: patientData)));
                        },
                        icon: Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors().mainColor(),
                          size: 30.0,
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 1.0,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  HRMSRoundedButton(
                    text: 'Update Profile',
                    fullWidth: true,
                    action: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) {
                                return const HRMSUpdatePatientScreen();
                              },
                              settings: RouteSettings(arguments: patientData)));
                    },
                  ),
                  const SizedBox(
                    height: 70.0,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
