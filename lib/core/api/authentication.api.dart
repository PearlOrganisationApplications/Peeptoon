import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../app/routes/api.routes.dart';

class AuthenticationAPI {
  final client = http.Client();
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': "*",
  };

//*** User Sign Up
  Future createAccount(
      {required String useremail,
      required String username,
      required String userpassword,
      required String userConfirmPassword,
      required String phoneNumber}) async {
    const subUrl = '/peeptoon/public/api/signup';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.post(uri,
        headers: headers,
        body: jsonEncode({
          "name": username,
          "email": useremail,
          "contact_no": phoneNumber,
          "password": userpassword,
          "confirm_password": userConfirmPassword,
        }));
    final dynamic body = response.body;
    print("Account Create =======> $body");
    return body;
  }

  Future userLogin(
      {required String useremail,
      required String userpassword,
      required String usercontact}) async {
    const subUrl = '/peeptoon/public/api/signin';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.post(uri,
        headers: headers,
        body: jsonEncode({
          "email": useremail,
          "contact_no": usercontact,
          "password": userpassword,
        }));
    final dynamic body = response.body;
    print("Account Create =======> $body");
    return body;
  }
}
