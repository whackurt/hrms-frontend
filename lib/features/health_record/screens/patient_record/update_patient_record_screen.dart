import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/text_styles.dart';
import 'package:hrms_frontend/features/health_record/controllers/patient.controller.dart';
import 'package:hrms_frontend/features/health_record/providers/patient.provider.dart';
import 'package:hrms_frontend/features/health_record/providers/zone.provider.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/content_wrapper.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/text_field/text_field.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';
import 'package:hrms_frontend/widgets/buttons/rounded_btn.dart';
import 'package:provider/provider.dart';

class HRMSUpdatePatientScreen extends StatefulWidget {
  const HRMSUpdatePatientScreen({super.key});

  @override
  State<HRMSUpdatePatientScreen> createState() =>
      _HRMSUpdatePatientScreenState();
}

class _HRMSUpdatePatientScreenState extends State<HRMSUpdatePatientScreen> {
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController brgyController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController provinceController = TextEditingController();

  PatientController patientController = PatientController();

  String selectedZone = '';
  String patientId = '';
  DateTime? birthDate;
  DateTime? newBirthDate;
  bool loading = false;
  bool success = false;

  Map updateData = {};
  Map patient = {};

  Future updateDataNotEmpty() async {
    newBirthDate != null
        ? updateData['birthDate'] = newBirthDate!.toIso8601String()
        : null;

    selectedZone != '' ? updateData['zone'] = selectedZone : null;

    lastNameController.text.isNotEmpty
        ? updateData['lastName'] = lastNameController.text.toString()
        : null;
    firstNameController.text.isNotEmpty
        ? updateData['firstName'] = firstNameController.text.toString()
        : null;
    streetController.text.isNotEmpty
        ? updateData['street'] = streetController.text.toString()
        : null;
    brgyController.text.isNotEmpty
        ? updateData['barangay'] = brgyController.text.toString()
        : null;
    cityController.text.isNotEmpty
        ? updateData['city_municipality'] = cityController.text.toString()
        : null;
    provinceController.text.isNotEmpty
        ? updateData['province'] = provinceController.text.toString()
        : null;

    return updateData.isNotEmpty;
  }

  Future saveUpdate() async {
    setState(() {
      loading = true;
    });
    await patientController
        .updatePatient(patientId: patientId, data: updateData)
        .then((res) {
      if (res['success']) {
        setState(() {
          loading = false;
          success = true;
          Future.delayed(const Duration(seconds: 3), () {
            setState(() {
              success = false;
            });
            updateData.clear();
            lastNameController.clear();
            firstNameController.clear();
            streetController.clear();
            brgyController.clear();
            cityController.clear();
            provinceController.clear();
          });
        });
      }
    });

    await patientController.getPatients().then((res) {
      context.read<PatientProvider>().setPatientList(data: res['data']['data']);
    });
  }

  @override
  Widget build(BuildContext context) {
    var patientData = ModalRoute.of(context)!.settings.arguments as Map;
    var zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    var patientProvider = Provider.of<PatientProvider>(context, listen: true);

    setState(() {
      patientId = patientData['_id'];
    });
    patient = patientProvider.patientList
        .firstWhere((patient) => patient['_id'] == patientId);

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
                hintText: "${patient['lastName']}",
                controller: lastNameController,
              ),
              HRMSTextField(
                label: "First Name",
                hintText: "${patient['firstName']}",
                controller: firstNameController,
              ),
              HRMSTextField(
                label: "Street Name",
                hintText: "${patient['street']}",
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
                // value: selectedZone,
                isExpanded: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.all(12), // Adjust the content padding
                  hintText: '${patient['zone']['zoneNumber']}',
                ),
                items: zoneProvider.zoneList.map((zone) {
                  return DropdownMenuItem<String>(
                    value: zone['_id'],
                    child: Text('${zone['zoneNumber']}'),
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
                hintText: "${patient['barangay']}",
                controller: brgyController,
              ),
              HRMSTextField(
                label: "City/Municipality",
                hintText: "${patient['city_municipality']}",
                controller: cityController,
              ),
              HRMSTextField(
                label: "Province",
                hintText: "${patient['province']}",
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
                initialDate: DateTime.tryParse(patient['birthDate']),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white),
                mode: DateTimeFieldPickerMode.date,
                onDateSelected: (DateTime value) {
                  setState(() {
                    newBirthDate = value;
                  });
                },
                selectedDate:
                    newBirthDate ?? DateTime.tryParse(patient['birthDate']),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  success ? 'Profile updated successfully.' : '',
                  style:
                      const TextStyle(color: Color.fromARGB(255, 28, 114, 31)),
                ),
              ),
              HRMSRoundedButton(
                fullWidth: true,
                action: () async {
                  var updateNotEmpty = await updateDataNotEmpty();

                  if (updateNotEmpty) {
                    saveUpdate();
                  }
                },
                child: loading
                    ? const SpinKitCircle(
                        color: Colors.white,
                        size: 30.0,
                      )
                    : const Text(
                        'Save Changes',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                      ),
              ),
              const SizedBox(
                height: 70.0,
              ),
            ],
          ),
        ));
  }
}
