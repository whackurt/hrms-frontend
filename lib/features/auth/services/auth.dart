import 'dart:convert';
import 'package:hrms_frontend/config/api.dart';
import 'package:hrms_frontend/features/auth/endpoints/auth_endpoints.dart';
import 'package:http/http.dart' as http;

class Authentication {
  // AuthEndpoint? authEndpoint;

  // LoginService(this.authEndpoint);

  void verifyAccess() {
    print('api called');
  }

  // Future login(String healthWorkerId, String password) async {
  //   String url = 'https://hrms-backend-yrn5.onrender.com/api/auth/login';
  //   Map<String, String> body = {'hwid': healthWorkerId, 'password': password};

  //   String basicauth =
  //       'Basic ${base64Encode(utf8.encode('$healthWorkerId:$password'))}';

  //   http.Response response = await http.post(
  //       // Uri.parse('https://hrms-backend-yrn5.onrender.com/api/auth/login'),
  //       Uri.parse(url),
  //       headers: <String, String>{
  //         // 'authorization': basicauth,
  //         'Content-Type': 'application/json',
  //         'accept': 'application/json'
  //       },
  //       body: jsonEncode(body));

  //   if (response.statusCode == 200) {
  //     var jsonRes = jsonDecode(response.body) as Map<String, dynamic>;
  //     return jsonRes;
  //   } else {
  //     return {'success': false};
  //   }
  // }

  Future login(
      {required String healthWorkerId, required String password}) async {
    String _baseUrl = 'https://hrms-backend-yrn5.onrender.com/api';

    Map parsed;

    try {
      return await http
          .post(Uri.parse('$_baseUrl/auth/login'), headers: <String, String>{
        'Context-Type': 'application/json; charset=UTF-8',
      }, body: {
        'hwid': healthWorkerId,
        'password': password
      }).then((response) {
        parsed = json.decode(response.body);

        if (response.statusCode == 200) {
          return true;
        }
      });
    } catch (e) {}
  }

  void getPatients() async {
    var response = await http
        .get(Uri.parse('https://hrms-backend-yrn5.onrender.com/api/patient'));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var items = jsonResponse['data'];
      print('data $items');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
