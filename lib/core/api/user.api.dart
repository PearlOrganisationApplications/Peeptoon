import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peerp_toon/app/constants/app.keys.dart';

import 'package:peerp_toon/core/models/userDetails.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/routes/api.routes.dart';

class UserAPI {
  final client = http.Client();

  ///*** Get Data Through User Token

  static Future<GetUserUpdateDetaile?> getUserUpdateDetaile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map data = {'token': preferences.getString(AppKeys.userData)};
    const subUrl = '/peeptoon/public/api/get-user';

    final response = await http.post(
      Uri.parse(ApiRoutes.baseurl + subUrl),
      headers: {
        'content-type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
      body: data,
      encoding: Encoding.getByName("utf-8"),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return GetUserUpdateDetaile.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception("Error");
    }
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
          "token": token,
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
