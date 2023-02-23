import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../app/routes/api.routes.dart';

class UserAPI {
  final client = http.Client();
///*** Get Data Through User Token
  Future getUserData({required String token}) async {
    const subUrl = '/auth/verify';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': "*",
        "Authorization": token
      },
    );
    final dynamic body = response.body;
    return body;
  }

  Future getUserDetails({required String userEmail}) async {
    var subUrl = '/info/$userEmail';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': "*",
      },
    );
    final dynamic body = response.body;
    return body;
  }

  Future updateUserDetails(
      {required String token,
        required String userEmail,
      required String userAddress,
      required String userPhoneNo}) async {
    const subUrl = '/peeptoon/public/api/update-user';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': "*",
        },
        body: jsonEncode({
          "token":token,
          "email": userEmail,
          "address": userAddress,
          "contact_no": userPhoneNo,
        }));
    final dynamic body = response.body;
    return body;
  }

  Future changePassword(
      {required String userEmail,
      required String oluserpassword,
      required String newuserpassword}) async {
    const subUrl = '/auth/change-password';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': "*",
        },
        body: jsonEncode({
          "oluserpassword": oluserpassword,
          "useremail": userEmail,
          "newuserpassword": newuserpassword
        }));
    final dynamic body = response.body;
    return body;
  }


}
