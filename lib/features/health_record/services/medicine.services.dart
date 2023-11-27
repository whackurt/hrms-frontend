import 'dart:convert';

import 'package:hrms_frontend/config/api.dart';
import 'package:hrms_frontend/features/health_record/models/medicine.model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MedicineServices {
  Api api = Api();

  Future getMedicines() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    http.Response response = await http.get(
      Uri.parse('${api.baseUrl}/medicine'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': pref.getString('token').toString(),
      },
    );

    Map jsonRes = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      print(jsonRes);
      return {"success": true, "data": jsonRes};
    } else {
      return {"success": false, "data": jsonRes};
    }
  }

  Future getMedicinesByPatientId({required String patientId}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    http.Response response = await http.get(
      Uri.parse('${api.baseUrl}/medicine/$patientId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': pref.getString('token').toString(),
      },
    );

    Map jsonRes = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      print(jsonRes);
      return {"success": true, "data": jsonRes};
    } else {
      return {"success": false, "data": jsonRes};
    }
  }

  Future createMedicine({required Medicine medicine}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    http.Response response =
        await http.post(Uri.parse('${api.baseUrl}/medicine'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'auth-token': pref.getString('token').toString(),
            },
            body: jsonEncode(medicine.toJson()));

    Map jsonRes = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 201) {
      return {"success": true, "data": jsonRes};
    } else {
      return {"success": false, "data": jsonRes};
    }
  }

  Future updateMedicine(
      {required String medicineId, required Map updateData}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    http.Response response =
        await http.put(Uri.parse('${api.baseUrl}/medicine/$medicineId'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'auth-token': pref.getString('token').toString(),
            },
            body: jsonEncode({"updates": updateData}));

    Map jsonRes = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return {"success": true, "data": jsonRes};
    } else {
      return {"success": false, "data": jsonRes};
    }
  }

  Future deleteMedicine({required String medicineId}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    http.Response response = await http.delete(
      Uri.parse('${api.baseUrl}/medicine/$medicineId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': pref.getString('token').toString(),
      },
    );

    Map jsonRes = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return {"success": true, "data": jsonRes};
    } else {
      return {"success": false, "data": jsonRes};
    }
  }
}
