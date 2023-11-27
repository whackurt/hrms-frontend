import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_frontend/features/health_record/controllers/medicine.controller.dart';
import 'package:hrms_frontend/features/health_record/providers/medicine.provider.dart';
import 'package:hrms_frontend/features/health_record/screens/patient_record/medicine/update_medicine_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HRMSMedicineCard extends StatefulWidget {
  final Map? med;
  const HRMSMedicineCard({super.key, this.med});

  @override
  State<HRMSMedicineCard> createState() => _HRMSMedicineCardState();
}

DateTime? dateGiven;

class _HRMSMedicineCardState extends State<HRMSMedicineCard> {
  TextEditingController medNameController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  MedicineController medicineController = MedicineController();

  Future getMedicines() async {
    await medicineController.getMedicines().then((res) {
      if (res['success']) {
        context
            .read<MedicineProvider>()
            .setMedicines(data: res['data']['data']);

        setState(() {
          // submitLoading = false;
        });
      }
    });
  }

  Future deleteMedicine(String medicineId) async {
    await medicineController.deleteMedicine(medicineId: medicineId).then((res) {
      if (res['success']) {
        getMedicines();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .70,
                    child: Text(
                      '${widget.med!['name']}',
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Date Given: ',
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.grey[700]),
                          ),
                          Text(
                            '${DateFormat('MMMM d, yyyy').format(DateTime.parse(widget.med!['dateGiven']))}, ',
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.grey[800]),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Quantity: ',
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.grey[700]),
                          ),
                          Text(
                            '${widget.med!['qty']}',
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.grey[800]),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    minSize: double.minPositive,
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.edit_outlined,
                        color: Colors.green[600], size: 25),
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) {
                                return const HRMSUpdateMedicineScreen();
                              },
                              settings: RouteSettings(arguments: widget.med!)));
                    },
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  CupertinoButton(
                    minSize: double.minPositive,
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.delete, color: Colors.red[500], size: 25),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Confirm Deletion',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            content: const Text(
                                'Are you sure you want to delete this medicine?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the alert dialog
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await deleteMedicine(widget.med!['_id']);

                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.red[800]),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
