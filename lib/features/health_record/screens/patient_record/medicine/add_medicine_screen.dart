import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hrms_frontend/core/theme/app_colors.dart';
import 'package:hrms_frontend/core/theme/text_styles.dart';
import 'package:hrms_frontend/features/health_record/controllers/medicine.controller.dart';
import 'package:hrms_frontend/features/health_record/models/medicine.model.dart';
import 'package:hrms_frontend/features/health_record/providers/medicine.provider.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/content_wrapper.dart';
import 'package:hrms_frontend/features/health_record/screens/widgets/text_field/text_field.dart';
import 'package:hrms_frontend/widgets/app_bar/hrms_appbar.dart';
import 'package:hrms_frontend/widgets/buttons/rounded_btn.dart';
import 'package:provider/provider.dart';

class HRMSAddMedicineScreen extends StatefulWidget {
  const HRMSAddMedicineScreen({super.key});

  @override
  State<HRMSAddMedicineScreen> createState() => _HRMSAddMedicineScreenState();
}

class _HRMSAddMedicineScreenState extends State<HRMSAddMedicineScreen> {
  TextEditingController medNameController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  final GlobalKey<FormState> _addMedicineKey = GlobalKey<FormState>();
  MedicineController medicineController = MedicineController();

  List<dynamic> zones = [];
  DateTime? dateGiven;
  String? selectedZone;

  bool loading = false;
  bool noDateSelected = false;
  bool submitLoading = false;
  bool success = false;

  Future getMedicines() async {
    await medicineController.getMedicines().then((res) {
      if (res['success']) {
        context
            .read<MedicineProvider>()
            .setMedicines(data: res['data']['data']);

        setState(() {
          submitLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getMedicines();
  }

  Future createMedicine(Medicine medicine) async {
    await medicineController.createMedicine(medicine: medicine).then((res) {
      if (res['success']) {
        setState(() {
          submitLoading = false;
          success = res['success'];
        });

        getMedicines();

        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            success = false;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patientData = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: HRMSAppBar(
            title: 'Add Medicine',
          )),
      body: RefreshIndicator(
        onRefresh: () async {
          _addMedicineKey.currentState!.reset();
        },
        child: HRMSContentWrapper(
          child: Form(
            key: _addMedicineKey,
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
                                'Add a Medicine',
                                style: sectionHeader(),
                              ),
                              const Text('Please enter required information')
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      HRMSTextField(
                        label: "Medicine Name",
                        hintText: "Enter Medicine Name",
                        controller: medNameController,
                        validator: (value) =>
                            value!.isEmpty ? 'Medicine name is required' : null,
                        onSaved: (value) {},
                      ),
                      HRMSTextField(
                        label: "Quantity",
                        hintText: "Enter Quantity Given",
                        controller: qtyController,
                        validator: (value) =>
                            value!.isEmpty ? 'Quantity is required' : null,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Date Given',
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
                            dateGiven = value;
                          });
                        },
                        lastDate: DateTime.now(),
                        selectedDate: dateGiven,
                      ),
                      noDateSelected
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  13.0, 0.0, 0.0, 15.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Date given is required.',
                                    style: TextStyle(
                                        color: Colors.red[600], fontSize: 11.0),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      success
                          ? Text(
                              'Medicine added successfully.',
                              style: TextStyle(color: Colors.green[600]),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      HRMSRoundedButton(
                        fullWidth: true,
                        action: () async {
                          if (dateGiven == null) {
                            setState(() {
                              noDateSelected = true;
                            });
                          } else {
                            setState(() {
                              noDateSelected = false;
                            });
                          }
                          if (_addMedicineKey.currentState!.validate() &&
                              !noDateSelected) {
                            setState(() {
                              submitLoading = true;
                              success = false;
                            });

                            _addMedicineKey.currentState!.save();
                            await createMedicine(Medicine(
                                name: medNameController.text,
                                qty: int.parse(qtyController.text),
                                patientId: patientData['patientId'],
                                dateGiven: dateGiven));
                            _addMedicineKey.currentState!.reset();
                          }
                        },
                        child: submitLoading
                            ? const SpinKitCircle(
                                color: Colors.white,
                                size: 30.0,
                              )
                            : const Text(
                                'Add Medicine',
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
