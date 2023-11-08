import 'package:flutter/material.dart';
import 'package:hrms_frontend/features/health_record/widgets/content_wrapper.dart';
import 'package:hrms_frontend/features/health_record/widgets/cards/zone_card.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';

class HRMSPatientRecordsScreen extends StatefulWidget {
  const HRMSPatientRecordsScreen({super.key});

  @override
  State<HRMSPatientRecordsScreen> createState() =>
      _HRMSPatientRecordsScreenState();
}

class _HRMSPatientRecordsScreenState extends State<HRMSPatientRecordsScreen> {
  List<Map<String, dynamic>> zoneInfo = [
    {
      "_id": "e6726e6g6sy87s1",
      "zoneNumber": 1,
      "zoneName": "Uno",
    },
    {
      "_id": "e6726e6g6sy87s2",
      "zoneNumber": 2,
      "zoneName": "Dos",
    },
    {
      "_id": "e6726e6g6sy87s3",
      "zoneNumber": 3,
      "zoneName": "Uno",
    },
    {
      "_id": "e6726e6g6sy87s4",
      "zoneNumber": 4,
      "zoneName": "Quatro",
    },
    {
      "_id": "e6726e6g6sy87s5",
      "zoneNumber": 5,
      "zoneName": "Singko",
    },
    {
      "_id": "e6726e6g6sy87s6",
      "zoneNumber": 6,
      "zoneName": "Sais",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: HRMSAppBar(
            title: 'Health Records',
          )),
      body: HRMSContentWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Column(
              children: zoneInfo.map((zone) {
                return HRMSZoneCard(
                  zoneInfo: zone,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
