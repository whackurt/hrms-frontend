import 'dart:convert';

import 'package:hrms_frontend/config/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
}
