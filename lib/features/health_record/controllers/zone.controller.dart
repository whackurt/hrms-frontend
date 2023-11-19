import 'dart:convert';

import 'package:hrms_frontend/config/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ZoneController {
  Api api = Api();

  Future getZones() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    http.Response response = await http.get(Uri.parse('${api.baseUrl}/zone'),
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
