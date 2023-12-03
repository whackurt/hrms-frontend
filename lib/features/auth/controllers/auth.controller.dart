import 'package:hrms_frontend/config/api.dart';
import 'package:hrms_frontend/features/auth/auth.services.dart';
import 'package:hrms_frontend/features/auth/models/admin.model.dart';
import 'package:hrms_frontend/features/auth/models/healthWorker.model.dart';

class AuthController {
  Api api = Api();
  AuthServices authServices = AuthServices();

  Future loginHealthworker(HealthWorker healthWorker) async {
    var res = await authServices.loginHealthworker(healthWorker);
    return res;
  }

  Future loginAdmin(Admin admin) async {
    var res = await authServices.loginAdmin(admin);
    return res;
  }

  Future createHealthworker(HealthWorker healthWorker) async {
    var res = await authServices.createHealthworker(healthWorker);
    return res;
  }
}
