import 'package:flutter/material.dart';
import 'package:hrms_frontend/features/health_record/providers/zone.provider.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/content_wrapper.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/cards/zone_card.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';
import 'package:provider/provider.dart';

class HRMSPatientRecordsScreen extends StatefulWidget {
  const HRMSPatientRecordsScreen({super.key});

  @override
  State<HRMSPatientRecordsScreen> createState() =>
      _HRMSPatientRecordsScreenState();
}

class _HRMSPatientRecordsScreenState extends State<HRMSPatientRecordsScreen> {
  @override
  Widget build(BuildContext context) {
    var zoneProvider = Provider.of<ZoneProvider>(context, listen: true);

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
              children: zoneProvider.zoneList.map((zone) {
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
