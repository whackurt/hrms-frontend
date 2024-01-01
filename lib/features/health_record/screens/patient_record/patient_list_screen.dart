import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/text_styles.dart';
import 'package:hrms_frontend/features/health_record/controllers/patient.controller.dart';
import 'package:hrms_frontend/features/health_record/providers/patient.provider.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/content_wrapper.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/cards/patient_list_card.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';
import 'package:provider/provider.dart';

class HRMSPatientListScreen extends StatefulWidget {
  const HRMSPatientListScreen({super.key});

  @override
  State<HRMSPatientListScreen> createState() => _HRMSPatientListScreenState();
}

class _HRMSPatientListScreenState extends State<HRMSPatientListScreen> {
  PatientController patientController = PatientController();

  List patients = [];
  var query = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map zoneData = ModalRoute.of(context)!.settings.arguments as Map;
    var patientProvider = Provider.of<PatientProvider>(context, listen: true);

    var zoneNumber = zoneData['zoneNumber'];

    patients = query != ''
        ? patients.where((patient) {
            String firstName = patient['firstName'].toLowerCase();
            String lastName = patient['lastName'].toLowerCase();
            String searchQuery = query.toLowerCase();

            return firstName.contains(searchQuery) ||
                lastName.contains(searchQuery);
          }).toList()
        : patientProvider.patientList
            .where((patient) => patient['zone']['_id'] == zoneData['zoneId'])
            .toList();

    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: HRMSAppBar(
              title: 'Patient List',
            )),
        body: HRMSContentWrapper(
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Icon(
                    Icons.person_pin_circle,
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
                        'Zone $zoneNumber',
                        style: sectionHeader(),
                      ),
                      const Text('List of Patient Health Records')
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextFormField(
                  enabled: patients.isNotEmpty,
                  onChanged: (value) {
                    setState(() {
                      query = value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              patients.isEmpty
                  ? Text('No patient found for Zone $zoneNumber')
                  : Column(
                      children: patients.map((patient) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: HRMSPatientListCard(
                            patientInfo: patient,
                          ),
                        );
                      }).toList(),
                    ),
              const SizedBox(height: 70.0),
            ],
          ),
        ));
  }
}
