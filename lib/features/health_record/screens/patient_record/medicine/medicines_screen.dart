import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_frontend/features/auth/screens/signup_screen.dart';
import 'package:hrms_frontend/features/health_record/controllers/medicine.controller.dart';
import 'package:hrms_frontend/features/health_record/models/medicine.model.dart';
import 'package:hrms_frontend/features/health_record/providers/medicine.provider.dart';
import 'package:hrms_frontend/features/health_record/screens/patient_record/medicine/add_medicine_screen.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/cards/medicine_card.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/content_wrapper.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';
import 'package:provider/provider.dart';

class HRMSViewMedicines extends StatefulWidget {
  const HRMSViewMedicines({super.key});

  @override
  State<HRMSViewMedicines> createState() => _HRMSViewMedicinesState();
}

class _HRMSViewMedicinesState extends State<HRMSViewMedicines> {
  MedicineController medicineController = MedicineController();

  final TextEditingController medNameController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

  String patientId = '';
  bool loading = false;
  List meds = [];
  DateTime? dateGiven;

  Future addMedicine(Medicine medicine) async {
    await medicineController.createMedicine(
        medicine: Medicine(
            name: nameController.text,
            qty: int.parse(qtyController.text),
            patientId: patientId,
            dateGiven: dateGiven));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final patientData = ModalRoute.of(context)!.settings.arguments as Map;
    var medicineProvider = Provider.of<MedicineProvider>(context, listen: true);

    setState(() {
      patientId = patientData['_id'];
    });

    meds = medicineProvider.medicines
        .where((med) => patientId == med['patientId']['_id'])
        .toList();

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: HRMSAppBar(
            title: 'Medicines/Vaccinations',
          )),
      body: HRMSContentWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) {
                              return const HRMSAddMedicineScreen();
                            },
                            settings: RouteSettings(
                                arguments: {"patientId": patientId})));
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add), // 'add' icon from Material Icons
                      SizedBox(
                          width: 5), // Add some space between the icon and text
                      Text(
                          'Add Medicine'), // Optional: Add text next to the icon
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: meds.isNotEmpty
                  ? meds.map((med) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          HRMSMedicineCard(
                            med: med,
                          )
                        ],
                      );
                    }).toList()
                  : [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.0),
                        child: Center(
                            child: Text('No Medicines/Vaccinations available')),
                      )
                    ],
            ),
          ],
        ),
      ),
    );
  }
}
