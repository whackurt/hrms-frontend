import 'dart:convert';
import 'package:hrms_frontend/config/api.dart';
import 'package:hrms_frontend/features/auth/models/healthWorker.model.dart';
import 'package:http/http.dart' as http;

class AuthController {
  Api api = Api();

  Future login(HealthWorker healthWorker) async {
    http.Response response = await http.post(
      Uri.parse('${api.baseUrl}/auth/login'),
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

  Future signup(HealthWorker healthWorker) async {
    http.Response response = await http.post(
      Uri.parse('${api.baseUrl}/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
      return {
        "success": false,
        "data": {"message": "Healthworker ID is taken already."}
      };
    }
  }
}
