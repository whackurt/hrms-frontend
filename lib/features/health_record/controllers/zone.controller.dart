import 'package:hrms_frontend/config/api.dart';
import 'package:hrms_frontend/features/health_record/services/zone.services.dart';

class ZoneController {
  Api api = Api();
  ZoneServices zoneServices = ZoneServices();

  Future getZones() async {
    var res = await zoneServices.getZones();
    return res;
  }
}
