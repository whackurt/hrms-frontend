import 'dart:convert';

import 'package:hrms_frontend/config/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:hrms_frontend/features/health_record/models/patient.model.dart';

class PatientController {
  Api api = Api();

  Future getPatients() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    http.Response response = await http.get(Uri.parse('${api.baseUrl}/patient'),
        headers: <String, String>{
          'auth-token': pref.getString('token').toString()
        });

    Map jsonRes = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return {"success": true, "data": jsonRes};
    } else {
      return {"success": false, "data": jsonRes};
    }
  }

  Future getPatientByZone({required String zoneId}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    http.Response response = await http.get(
        Uri.parse('${api.baseUrl}/patient/zone/$zoneId'),
        headers: <String, String>{
          'auth-token': pref.getString('token').toString()
        });

    Map jsonRes = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return {"success": true, "data": jsonRes};
    } else {
      return {"success": false, "data": jsonRes};
    }
  }

  Future createPatient({required Patient patient}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    http.Response response =
        await http.post(Uri.parse('${api.baseUrl}/patient'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'auth-token': pref.getString('token').toString(),
            },
            body: jsonEncode(patient.toJson()));

    Map jsonRes = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 201) {
      return {"success": true, "data": jsonRes};
    } else {
      return {"success": false, "data": jsonRes};
    }
  }
}
