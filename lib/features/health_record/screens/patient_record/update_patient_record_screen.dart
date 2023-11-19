import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/text_styles.dart';
import 'package:hrms_frontend/features/health_record/widgets/content_wrapper.dart';
import 'package:hrms_frontend/features/health_record/widgets/text_field/text_field.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';
import 'package:hrms_frontend/widgets/buttons/rounded_btn.dart';

class HRMSUpdatePatientScreen extends StatefulWidget {
  const HRMSUpdatePatientScreen({super.key});

  @override
  State<HRMSUpdatePatientScreen> createState() =>
      _HRMSUpdatePatientScreenState();
}

DateTime? birthDate;

class _HRMSUpdatePatientScreenState extends State<HRMSUpdatePatientScreen> {
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController brgyController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController provinceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var patientData = ModalRoute.of(context)!.settings.arguments as Map;
    List zones = [];

    lastNameController.text = patientData['lastName'];
    firstNameController.text = patientData['firstName'];
    streetController.text = patientData['street'];
    brgyController.text = patientData['brgy'];
    cityController.text = patientData['city_municipality'];
    provinceController.text = patientData['province'];
    String selectedZone = zones.first;
    selectedZone = zones[patientData['zone'] - 1];
    birthDate = DateTime.parse(patientData['birthDate']);

    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: HRMSAppBar(
              title: 'Update Profile',
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
                        'Update Patient Profile',
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
                label: "Last Name",
                hintText: "${patientData['lastName']}",
                controller: lastNameController,
              ),
              HRMSTextField(
                label: "First Name",
                hintText: "Enter First Name",
                controller: firstNameController,
              ),
              HRMSTextField(
                label: "Street Name",
                hintText: "Enter Street Name",
                controller: streetController,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Zone',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
                  ),
                ],
              ),
              DropdownButtonFormField<String>(
                value: selectedZone,
                isExpanded: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.all(12), // Adjust the content padding
                  hintText: 'Select Zone',
                ),
                items: zones.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedZone = newValue!;
                  });
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              HRMSTextField(
                label: "Barangay",
                hintText: "Enter Barangay",
                controller: brgyController,
              ),
              HRMSTextField(
                label: "City/Municipality",
                hintText: "Enter City/Municipality",
                controller: cityController,
              ),
              HRMSTextField(
                label: "Province",
                hintText: "Enter Province",
                controller: provinceController,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Birth Date',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
                  ),
                ],
              ),
              DateTimeField(
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white),
                mode: DateTimeFieldPickerMode.date,
                onDateSelected: (DateTime value) {
                  setState(() {
                    birthDate = value;
                  });
                },
                selectedDate: birthDate,
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
                        content: const Text(
                            'Are you sure you want to save changes?'),
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
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 70.0,
              ),
            ],
          ),
        ));
  }
}
