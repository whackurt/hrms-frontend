import 'package:hrms_frontend/config/api.dart';
import 'package:hrms_frontend/features/health_record/services/patient.services.dart';
import 'package:hrms_frontend/features/health_record/models/patient.model.dart';

class PatientController {
  Api api = Api();
  PatientServices patientServices = PatientServices();

  Future getPatients() async {
    var res = await patientServices.getPatients();
    return res;
  }

  Future getPatientByZone({required String zoneId}) async {
    var res = await patientServices.getPatientByZone(zoneId: zoneId);
    return res;
  }

  Future createPatient({required Patient patient}) async {
    var res = await patientServices.createPatient(patient: patient);
    return res;
  }

  Future updatePatient({required String patientId, required data}) async {
    var res =
        await patientServices.updatePatientProfile(id: patientId, data: data);
    return res;
  }
}
