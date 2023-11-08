import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/text_styles.dart';
import 'package:hrms_frontend/features/health_record/widgets/content_wrapper.dart';
import 'package:hrms_frontend/features/health_record/widgets/text_field/text_field.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';
import 'package:hrms_frontend/widgets/buttons/rounded_btn.dart';

class HRMSUpdateMedicineScreen extends StatefulWidget {
  const HRMSUpdateMedicineScreen({super.key});

  @override
  State<HRMSUpdateMedicineScreen> createState() =>
      _HRMSUpdateMedicineScreenState();
}

DateTime? dateGiven;

class _HRMSUpdateMedicineScreenState extends State<HRMSUpdateMedicineScreen> {
  TextEditingController medNameController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  Map<String, dynamic> updateData = {};

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
          Text('upda: $updateData'),
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
                dateGiven = value;
                updateData['dateGiven'] = dateGiven.toString().substring(0, 10);
              });
            },
            selectedDate: dateGiven,
          ),
          const SizedBox(
            height: 20.0,
          ),
          HRMSRoundedButton(
            text: "Save Changes",
            fullWidth: true,
            action: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Confirm Update',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    content:
                        const Text('Are you sure you want to save changes?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the alert dialog
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the alert dialog
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      )),
    );
  }
}
