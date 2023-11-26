import 'package:flutter/foundation.dart';

class PatientProvider extends ChangeNotifier {
  List patientList = [];

  void setPatientList({required List data}) {
    patientList = data;
    notifyListeners();
  }
}
