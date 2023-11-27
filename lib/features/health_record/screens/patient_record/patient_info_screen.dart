import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/text_styles.dart';
import 'package:hrms_frontend/features/health_record/providers/medicine.provider.dart';
import 'package:hrms_frontend/features/health_record/providers/patient.provider.dart';
import 'package:hrms_frontend/features/health_record/screens/patient_record/medicine/medicines_screen.dart';
import 'package:hrms_frontend/features/health_record/screens/patient_record/update_patient_record_screen.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/cards/patient_info_text.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/content_wrapper.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';
import 'package:hrms_frontend/widgets/buttons/rounded_btn.dart';
import 'package:provider/provider.dart';
import 'package:hrms_frontend/features/health_record/controllers/medicine.controller.dart';

class HRMSPatientInfoScreen extends StatefulWidget {
  const HRMSPatientInfoScreen({super.key});

  @override
  State<HRMSPatientInfoScreen> createState() => _HRMSPatientInfoScreenState();
}

DateTime? dateGiven;

class _HRMSPatientInfoScreenState extends State<HRMSPatientInfoScreen> {
  MedicineController medicineController = MedicineController();

  Map patient = {};
  bool loading = false;
  String patientId = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final patientData = ModalRoute.of(context)!.settings.arguments as Map;
    var patientProvider = Provider.of<PatientProvider>(context, listen: true);

    setState(() {
      patientId = patientData['_id'];
    });

    patient = patientProvider.patientList
        .firstWhere((patient) => patient['_id'] == patientData['_id']);

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
                    text: '${patient['lastName']}, ${patient['firstName']}',
                  ),
                  HRMSPatientInfoText(
                    label: 'Zone',
                    text: '${patient['zone']['zoneNumber']}',
                  ),
                  HRMSPatientInfoText(
                    label: 'Street Address',
                    text: '${patient['street']}',
                  ),
                  HRMSPatientInfoText(
                    label: 'Barangay',
                    text: '${patient['barangay']}',
                  ),
                  HRMSPatientInfoText(
                    label: 'City/Municipality',
                    text: '${patient['city_municipality']}',
                  ),
                  HRMSPatientInfoText(
                    label: 'Province',
                    text: '${patient['province']}',
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
                    fullWidth: true,
                    action: () {
                      context
                          .read<MedicineProvider>()
                          .setPatientId(id: patientData['_id']);
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) {
                                return const HRMSUpdatePatientScreen();
                              },
                              settings: RouteSettings(arguments: patientData)));
                    },
                    child: const Text(
                      'Update Profile',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
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
