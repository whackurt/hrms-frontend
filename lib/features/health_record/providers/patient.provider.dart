import 'package:flutter/foundation.dart';

class PatientProvider extends ChangeNotifier {
  List patientList = [];
  List zonePatients = [];

  void setPatientList({required List data}) {
    patientList = data;
    notifyListeners();
  }

  void setZonePatients({required List data}) {
    zonePatients = data;
    notifyListeners();
  }
}
