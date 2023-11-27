import 'package:hrms_frontend/features/health_record/models/medicine.model.dart';
import 'package:hrms_frontend/features/health_record/services/medicine.services.dart';

class MedicineController {
  MedicineServices medicineServices = MedicineServices();

  Future getMedicines() async {
    var res = await medicineServices.getMedicines();
    return res;
  }

  Future getMedicinesByPatientId({required String patientId}) async {
    var res =
        await medicineServices.getMedicinesByPatientId(patientId: patientId);
    return res;
  }

  Future createMedicine({required Medicine medicine}) async {
    var res = await medicineServices.createMedicine(medicine: medicine);
    return res;
  }

  Future updateMedicine(
      {required String medicineId, required Map updateData}) async {
    var res = await medicineServices.updateMedicine(
        medicineId: medicineId, updateData: updateData);
    return res;
  }

  Future deleteMedicine({required String medicineId}) async {
    var res = await medicineServices.deleteMedicine(medicineId: medicineId);
    return res;
  }
}
