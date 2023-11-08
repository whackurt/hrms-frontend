import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/features/health_record/widgets/cards/medicine_card.dart';
import 'package:hrms_frontend/features/health_record/widgets/content_wrapper.dart';
import 'package:hrms_frontend/features/health_record/widgets/text_field/text_field.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';

class HRMSViewMedicines extends StatefulWidget {
  const HRMSViewMedicines({super.key});

  @override
  State<HRMSViewMedicines> createState() => _HRMSViewMedicinesState();
}

DateTime? dateGiven;

class _HRMSViewMedicinesState extends State<HRMSViewMedicines> {
  final TextEditingController medNameController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

  List<Map<String, dynamic>> medicines = [
    {
      "_id": "5bf142459b72e12b2b1b2cd",
      "name": "Phenylephrine HCl Chlorphenamine Maleate Paracetamol",
      "qty": 3,
      "dateGiven": "2023-09-21"
    },
    {
      "_id": "5bf142459b72e12b2b1b2yf",
      "name": "Mefenamic Acid",
      "qty": 4,
      "dateGiven": "2023-08-08"
    },
    {
      "_id": "5bf142459b72e12b2b1b2mf",
      "name": "Robust Extreme",
      "qty": 2,
      "dateGiven": "2023-10-11"
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                Container(
                  padding: const EdgeInsets.only(left: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1,
                        offset: Offset(2, 2), // Shadow position
                      ),
                    ],
                  ),
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Add Medicine'),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.grey[100],
                                title: const Text(
                                  'Add Medicine',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                content: SizedBox(
                                  height: 280.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      HRMSTextField(
                                        label: 'Name of Medicine',
                                        hintText: 'Enter medicine name',
                                        controller: medNameController,
                                      ),
                                      HRMSTextField(
                                        label: 'Quantity',
                                        hintText: 'Enter medicine name',
                                        controller: qtyController,
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Date Given',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15.0),
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
                                          });
                                        },
                                        selectedDate: dateGiven,
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the alert dialog
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the alert dialog
                                    },
                                    child: const Text('Add'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.add_circle,
                          color: AppColors().mainColor(),
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: medicines.map((med) {
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
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
