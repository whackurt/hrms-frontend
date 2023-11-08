import 'package:hrms_frontend/config/api.dart';

class AuthEndpoint {
  Api api = Api();
  String? loginEndpoint;
  String? signupEndpoint;

  AuthEndpoint() {
    loginEndpoint = '${api.baseUrl}/auth/login';
    signupEndpoint = '${api.baseUrl}/auth/signup';
  }
}
