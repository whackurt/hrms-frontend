import 'package:flutter/material.dart';

class MedicineProvider extends ChangeNotifier {
  List patientMedicine = [];
  List medicines = [];
  String patientId = '';

  void setPatientMedicine({required List data}) {
    patientMedicine = data;
    notifyListeners();
  }

  void setMedicines({required List data}) {
    medicines = data;
    notifyListeners();
  }

  void setPatientId({required String id}) {
    patientId = id;
    notifyListeners();
  }
}
