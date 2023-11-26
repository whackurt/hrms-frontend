import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/text_styles.dart';
import 'package:hrms_frontend/features/health_record/controllers/patient.controller.dart';
import 'package:hrms_frontend/features/health_record/controllers/zone.controller.dart';
import 'package:hrms_frontend/features/health_record/models/patient.model.dart';
import 'package:hrms_frontend/features/health_record/providers/patient.provider.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/content_wrapper.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/text_field/text_field.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';
import 'package:hrms_frontend/widgets/buttons/rounded_btn.dart';
import 'package:provider/provider.dart';

class HRMSAddPatientScreen extends StatefulWidget {
  const HRMSAddPatientScreen({super.key});

  @override
  State<HRMSAddPatientScreen> createState() => _HRMSAddPatientScreenState();
}

class _HRMSAddPatientScreenState extends State<HRMSAddPatientScreen> {
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController brgyController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController provinceController = TextEditingController();

  final ZoneController zoneController = ZoneController();
  final PatientController patientController = PatientController();
  final GlobalKey<FormState> _addRecordKey = GlobalKey<FormState>();

  List<dynamic> zones = [];
  DateTime? birthDate;
  String? selectedZone;

  bool loading = false;
  bool noDateSelected = false;
  bool submitLoading = false;
  bool success = false;

  @override
  void initState() {
    super.initState();
    getZones();
  }

  Future getZones() async {
    setState(() {
      loading = true;
    });
    await zoneController.getZones().then((res) {
      if (res['success']) {
        setState(() {
          zones = res['data']['data'];
          selectedZone = zones.first['_id'];
          loading = false;
        });
      }
    });
  }

  Future getPatients() async {
    await patientController.getPatients().then((res) {
      if (res['success']) {
        context
            .read<PatientProvider>()
            .setPatientList(data: res['data']['data']);
      }
    });
  }

  Future createRecord(Patient patient) async {
    await patientController.createPatient(patient: patient).then((res) {
      if (res['success']) {
        setState(() {
          submitLoading = false;
          success = res['success'];
        });

        firstNameController.clear();
        lastNameController.clear();
        streetController.clear();
        brgyController.clear();
        cityController.clear();
        provinceController.clear();
        setState(() {
          selectedZone = zones.first['_id'];
          birthDate = null;
        });
        // _addRecordKey.currentState!.reset();
        getPatients();
      }
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    streetController.dispose();
    brgyController.dispose();
    cityController.dispose();
    provinceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: HRMSAppBar(
            title: 'Add Record',
          )),
      body: RefreshIndicator(
        onRefresh: () async {
          _addRecordKey.currentState!.reset();
        },
        child: HRMSContentWrapper(
          child: Form(
            key: _addRecordKey,
            child: loading
                ? Center(
                    child: SpinKitCircle(
                      color: AppColors().mainColor(),
                    ),
                  )
                : Column(
                    children: [
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          Icon(
                            Icons.add_circle,
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
                                'Add a Record',
                                style: sectionHeader(),
                              ),
                              const Text(
                                  'Please enter required patient information')
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      HRMSTextField(
                        label: "Last Name",
                        hintText: "Enter Last Name",
                        controller: lastNameController,
                        validator: (value) =>
                            value!.isEmpty ? 'Last name is required' : null,
                        onSaved: (value) {},
                      ),
                      HRMSTextField(
                        label: "First Name",
                        hintText: "Enter First Name",
                        controller: firstNameController,
                        validator: (value) =>
                            value!.isEmpty ? 'First name is required' : null,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Birth Date',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15.0),
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
                            noDateSelected = false;
                            birthDate = value;
                          });
                        },
                        lastDate: DateTime.now(),
                        selectedDate: birthDate,
                      ),
                      noDateSelected
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  13.0, 0.0, 0.0, 15.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Birth date is required.',
                                    style: TextStyle(
                                        color: Colors.red[600], fontSize: 11.0),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 8.0,
                      ),
                      HRMSTextField(
                          label: "Street Name",
                          hintText: "Enter Street Name",
                          controller: streetController,
                          validator: (value) => value!.isEmpty
                              ? 'Street name is required'
                              : null),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Zone',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15.0),
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
                        items: zones.map((zone) {
                          return DropdownMenuItem<String>(
                            value: zone['_id'],
                            child: Text('Zone ${zone['zoneNumber']}'),
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
                        validator: (value) =>
                            value!.isEmpty ? 'Barangay is required' : null,
                      ),
                      HRMSTextField(
                        label: "City/Municipality",
                        hintText: "Enter City/Municipality",
                        controller: cityController,
                        validator: (value) => value!.isEmpty
                            ? 'City/Municipality is required'
                            : null,
                      ),
                      HRMSTextField(
                        label: "Province",
                        hintText: "Enter Province",
                        controller: provinceController,
                        validator: (value) =>
                            value!.isEmpty ? 'Province is required' : null,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      success
                          ? Text(
                              'Record created successfully.',
                              style: TextStyle(color: Colors.green[600]),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      HRMSRoundedButton(
                        fullWidth: true,
                        action: () async {
                          if (birthDate == null) {
                            setState(() {
                              noDateSelected = true;
                            });
                          } else {
                            setState(() {
                              noDateSelected = false;
                            });
                          }
                          if (_addRecordKey.currentState!.validate()) {
                            var patient = Patient(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                birthDate: birthDate,
                                street: streetController.text,
                                zone: '$selectedZone',
                                barangay: brgyController.text,
                                cityMunicipality: cityController.text,
                                province: provinceController.text);

                            setState(() {
                              submitLoading = true;
                              success = false;
                            });

                            _addRecordKey.currentState!.save();

                            await createRecord(patient);

                            _addRecordKey.currentState!.reset();
                          }
                        },
                        child: submitLoading
                            ? const SpinKitCircle(
                                color: Colors.white,
                                size: 30.0,
                              )
                            : const Text(
                                'Add Record',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0),
                              ),
                      ),
                      const SizedBox(
                        height: 70.0,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
