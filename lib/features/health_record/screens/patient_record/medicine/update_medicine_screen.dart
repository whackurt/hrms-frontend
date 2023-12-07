import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/text_styles.dart';
import 'package:hrms_frontend/features/health_record/controllers/medicine.controller.dart';
import 'package:hrms_frontend/features/health_record/providers/medicine.provider.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/content_wrapper.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/text_field/text_field.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';
import 'package:hrms_frontend/widgets/buttons/rounded_btn.dart';
import 'package:provider/provider.dart';

class HRMSUpdateMedicineScreen extends StatefulWidget {
  const HRMSUpdateMedicineScreen({super.key});

  @override
  State<HRMSUpdateMedicineScreen> createState() =>
      _HRMSUpdateMedicineScreenState();
}

class _HRMSUpdateMedicineScreenState extends State<HRMSUpdateMedicineScreen> {
  TextEditingController medNameController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  MedicineController medicineController = MedicineController();

  Map<String, dynamic> updateData = {};

  DateTime? newDateGiven;
  bool loading = false;
  bool success = false;

  Future saveChanges({required String medicineId, required Map data}) async {
    setState(() {
      loading = true;
      success = false;
    });
    await medicineController
        .updateMedicine(medicineId: medicineId, updateData: data)
        .then((res) async {
      if (res['success']) {
        setState(() {
          success = true;
        });
      }
    });

    if (success) {
      await medicineController.getMedicines().then((res) {
        if (res['success']) {
          context
              .read<MedicineProvider>()
              .setMedicines(data: res['data']['data']);

          setState(() {
            loading = false;
          });

          // Future.delayed(const Duration(seconds: 3), () {
          //   setState(() {
          //     success = false;
          //   });
          // });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map medicineData = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: HRMSAppBar(
            title: 'Update Medicine/Vaccination',
          )),
      body: HRMSContentWrapper(
          child: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Icon(
                Icons.edit_note,
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
                    'Update Medicine',
                    style: sectionHeader(),
                  ),
                  const Text('Enter necessary update information')
                ],
              )
            ],
          ),
          const SizedBox(
            height: 40.0,
          ),
          HRMSTextField(
            label: 'Name of Medicine',
            hintText: '${medicineData['name']}',
            controller: medNameController,
            onChanged: (value) {
              setState(() {
                updateData['name'] = medNameController.text;
              });
            },
          ),
          HRMSTextField(
            label: 'Quantity',
            hintText: '${medicineData['qty']}',
            controller: qtyController,
            onChanged: (value) {
              setState(() {
                updateData['qty'] = int.parse(qtyController.text);
              });
            },
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Date Given',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
              ),
            ],
          ),
          DateTimeField(
            lastDate: DateTime.now(),
            decoration: const InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white),
            mode: DateTimeFieldPickerMode.date,
            onDateSelected: (DateTime value) {
              setState(() {
                newDateGiven = value;
                updateData['dateGiven'] = newDateGiven.toString();
              });
            },
            selectedDate:
                newDateGiven ?? DateTime.parse(medicineData['dateGiven']),
          ),
          const SizedBox(
            height: 20.0,
          ),
          success
              ? Text(
                  'Changes saved successfully.',
                  style: TextStyle(color: Colors.green[800]),
                )
              : const SizedBox(),
          const SizedBox(
            height: 10.0,
          ),
          HRMSRoundedButton(
            text: "Save Changes",
            fullWidth: true,
            action: () {
              if (updateData.isNotEmpty) {
                saveChanges(medicineId: medicineData['_id'], data: updateData);
              }
            },
            child: loading
                ? const SpinKitCircle(
                    color: Colors.white,
                    size: 30.0,
                  )
                : const Text(
                    'Save Changes',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                  ),
          ),
        ],
      )),
    );
  }
}
