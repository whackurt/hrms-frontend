import 'package:hrms_frontend/config/api.dart';
import 'package:hrms_frontend/features/auth/models/admin.model.dart';
import 'package:hrms_frontend/features/auth/models/healthWorker.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  Api api = Api();

  Future loginAdmin(Admin admin) async {
    http.Response response = await http.post(
      Uri.parse('${api.baseUrl}/auth/admin/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': admin.username,
        'password': admin.password
      }),
    );

    Map jsonRes = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return {"success": true, "data": jsonRes};
    } else {
      return {"success": false, "data": jsonRes};
    }
  }

  Future loginHealthworker(HealthWorker healthWorker) async {
    http.Response response = await http.post(
      Uri.parse('${api.baseUrl}/auth/healthworker/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'hwid': healthWorker.healthWorkerId,
        'password': healthWorker.password
      }),
    );

    Map jsonRes = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return {"success": true, "data": jsonRes};
    } else {
      return {"success": false, "data": jsonRes};
    }
  }

  Future createHealthworker(HealthWorker healthWorker) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    http.Response response = await http.post(
      Uri.parse('${api.baseUrl}/auth/healthworker/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': pref.getString('adminToken').toString(),
      },
      body: jsonEncode(<String, String>{
        'name': healthWorker.name,
        'hwid': healthWorker.healthWorkerId,
        'password': healthWorker.password
      }),
    );

    Map jsonRes = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 201) {
      return {"success": true, "data": jsonRes};
    } else {
      return {"success": false, "data": jsonRes};
    }
  }
}
