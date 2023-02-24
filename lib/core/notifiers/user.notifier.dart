import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/constants/app.keys.dart';
import '../../app/routes/app.routes.dart';
import '../api/user.api.dart';
import '../models/update.user.model.dart';

import '../utils/snackbar.util.dart';

class UserNotifier with ChangeNotifier {
  final UserAPI _userAPI = UserAPI();

  String? userEmail = 'Not Available';

  String? get getUserEmail => userEmail;

  String userAddress = 'Not Available';

  String get getuserAddress => userAddress;

  String userPhoneNumber = 'Not Available';

  String get getuserPhoneNumber => userPhoneNumber;

  ///***** Update Details Notifier. ***///
  Future updateUserDetails({
    required String userEmail,
    required String userAddress,
    required String userPhoneNo,
    required String token,
    required BuildContext context,
  }) async {
    try {
      var userDetaile = await _userAPI.updateUserDetails(
          userEmail: userEmail,
          userAddress: userAddress,
          userPhoneNo: userPhoneNo,
          token: token);
      print(userDetaile);
      final Map<String, dynamic> parseData = jsonDecode(userDetaile);
      // var response = UpdateUser.fromJson(jsonDecode(userDetaile));
      bool isAuthenticate = parseData['status'];
      dynamic authData = parseData['token'];
      if (isAuthenticate) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString(AppKeys.userData, authData).whenComplete(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
              text: "Detail Update Successfully", context: context));
          Navigator.of(context).pushReplacementNamed(AppRouter.profileRoute);
        });
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
            text: 'Oops No You Need A Good Internet Connection',
            context: context),
      );
    }
  }

  Future changePassword({
    required String userEmail,
    required String oluserpassword,
    required String newuserpassword,
    required BuildContext context,
  }) async {
    try {
      var userData = await _userAPI.changePassword(
          userEmail: userEmail,
          oluserpassword: oluserpassword,
          newuserpassword: newuserpassword);

      var response = ChangeUserPassword.fromJson(jsonDecode(userData));
      final _updated = response.updated;

      notifyListeners();

      return _updated;
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
            text: 'Oops No You Need A Good Internet Connection',
            context: context),
      );
    }
  }
}
