import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/text_styles.dart';
import 'package:hrms_frontend/features/health_record/controllers/medicine.controller.dart';
import 'package:hrms_frontend/features/health_record/providers/medicine.provider.dart';
import 'package:hrms_frontend/features/health_record/providers/zone.provider.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/content_wrapper.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/cards/zone_card.dart';
import 'package:provider/provider.dart';

class HRMSPatientRecordsScreen extends StatefulWidget {
  const HRMSPatientRecordsScreen({super.key});

  @override
  State<HRMSPatientRecordsScreen> createState() =>
      _HRMSPatientRecordsScreenState();
}

class _HRMSPatientRecordsScreenState extends State<HRMSPatientRecordsScreen> {
  bool loading = false;

  MedicineController medicineController = MedicineController();
  Future getMedicines() async {
    setState(() {
      loading = true;
    });
    await medicineController.getMedicines().then((res) {
      if (res['success']) {
        context
            .read<MedicineProvider>()
            .setMedicines(data: res['data']['data']);

        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getMedicines();
  }

  @override
  Widget build(BuildContext context) {
    var zoneProvider = Provider.of<ZoneProvider>(context, listen: true);

    return Scaffold(
      // appBar: const PreferredSize(
      //     preferredSize: Size.fromHeight(50),
      //     child: HRMSAppBar(
      //       title: 'Health Records',
      //     )),
      body: HRMSContentWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Row(
              children: [
                Icon(
                  Icons.list_alt_rounded,
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
                      'Health Records',
                      style: sectionHeader(),
                    ),
                    const Text('Explore and manage patient health records')
                  ],
                )
              ],
            ),
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
