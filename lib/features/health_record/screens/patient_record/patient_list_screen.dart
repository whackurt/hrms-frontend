import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/text_styles.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/content_wrapper.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/cards/patient_list_card.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';

class HRMSPatientListScreen extends StatefulWidget {
  const HRMSPatientListScreen({super.key});

  @override
  State<HRMSPatientListScreen> createState() => _HRMSPatientListScreenState();
}

class _HRMSPatientListScreenState extends State<HRMSPatientListScreen> {
  @override
  Widget build(BuildContext context) {
    Map zoneData = ModalRoute.of(context)!.settings.arguments as Map;

    var zoneNumber = zoneData['zoneNumber'];
    // var zoneId = zoneData['zoneId'];

    List<Map<String, dynamic>> patientList = [
      {
        "_id": "89w8busdjh9w9eury89",
        "firstName": "Irish Jane Marie Claire",
        "lastName": "Bajarla",
        "address": "Zone 3 Tres",
        "street": "Magdadaro St.",
        "brgy": "Bayabas",
        "city_municipality": "Cagayan de Oro",
        "province": "Misamis Oriental",
        "zone": 6,
        "birthDate": "2002-08-08"
      },
      {
        "_id": "89w8busdjh9w9eury98",
        "firstName": "Hanz Mariel Kent Joe Mario",
        "lastName": "Ibarra",
        "address": "Zone 5 Singko",
        "street": "Caballero St.",
        "brgy": "Puerto",
        "city_municipality": "Cagayan de Oro",
        "province": "Misamis Oriental",
        "zone": 5,
        "birthDate": "2002-08-11"
      },
      {
        "_id": "89w8busdjh9w9eur56",
        "firstName": "Gabriel",
        "lastName": "Balagulan",
        "address": "Zone 2 Dos",
        "street": "Caballero St.",
        "brgy": "Puerto",
        "city_municipality": "Cagayan de Oro",
        "province": "Misamis Oriental",
        "zone": 3,
        "birthDate": "2002-08-08"
      },
    ];

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
              Column(
                children: patientList.map((patient) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: HRMSPatientListCard(
                      patientInfo: patient,
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ));
  }
}
