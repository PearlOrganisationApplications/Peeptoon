import 'dart:convert';
import 'dart:io';

import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';

import '../../app/constants/app.keys.dart';
import '../../app/routes/app.routes.dart';
import '../api/authentication.api.dart';
import '../utils/snackbar.util.dart';

class AuthenticationNotifier with ChangeNotifier {
  final AuthenticationAPI _authenticationAPI = AuthenticationAPI();

  String? _passwordLevel = "";

  String? get passwordLevel => _passwordLevel;

  String? _passwordEmoji = "";

  String? get passwordEmoji => _passwordEmoji;

  void checkPasswordStrength({required String password}) {
    String mediumPattern = r'^(?=.*?[!@#\$&*~]).{8,}';
    String strongPattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    if (password.contains(RegExp(strongPattern))) {
      _passwordEmoji = '🚀';
      _passwordLevel = 'Strong';
      notifyListeners();
    } else if (password.contains(RegExp(mediumPattern))) {
      _passwordEmoji = '🔥';
      _passwordLevel = 'Medium';
      notifyListeners();
    } else if (!password.contains(RegExp(strongPattern))) {
      _passwordEmoji = '😢';
      _passwordLevel = 'Weak';
      notifyListeners();
    }
  }

  ///*** Create a notifier for to sign up "We have to Pass the parameter which we're required "
  Future createAccount(
      {required String useremail,
      required BuildContext context,
      required String username,
      required String userpassword,
      required String userConfirmPassword,
      required String phoneNumber}) async {
    try {
      var userData = await _authenticationAPI.createAccount(
        useremail: useremail,
        username: username,
        userpassword: userpassword,
        phoneNumber: phoneNumber,
        userConfirmPassword: userConfirmPassword,
      );
      print(userData);

      final Map<String, dynamic> parseData = await jsonDecode(userData);
      bool isAuthenticated = parseData['status'];
      dynamic authData = parseData['token'];

      if (isAuthenticated) {
        WriteCache.setString(key: AppKeys.userData, value: authData)
            .whenComplete(
          () => Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
            text: "User already Exist", context: context));
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
          text: 'Oops No! You Need A Good Internet Connection',
          context: context));
    } catch (e) {
      print(e);
    }
  }

  Future userLogin(
      {required String useremail,
      required BuildContext context,
      required String usercontact,
      required String userpassword}) async {
    try {
      var userData = await _authenticationAPI.userLogin(
          useremail: useremail,
          userpassword: userpassword,
          usercontact: usercontact);
      print(userData);

      final Map<String, dynamic> parseData = await jsonDecode(userData);
      bool isAuthenticated = parseData['status'];
      dynamic authData = parseData['token'];

      if (isAuthenticated) {
        WriteCache.setString(key: AppKeys.userData, value: authData)
            .whenComplete(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
              text: "Login Successfully", context: context));
          Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
            text: "Invail Username or Password", context: context));
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context));
    } catch (e) {
      print(e);
    }
  }

  Future forgotPassword(
      {required String email, required BuildContext context}) async {
    try {
      var userData = await _authenticationAPI.forgotPassword(email: email);
      print(userData);
      final Map<String, dynamic> parseData = jsonDecode(userData);
      bool isAuthenticated = parseData['status'];
      dynamic authData = ['message'];
      if (isAuthenticated) {}
      //   WriteCache.setString(key: "OTP SENDED SUCCESSFULLY", value: authData)
      //       .whenComplete(() {
      //
      // }
      ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
          text: "OTP SEND TO YOUR MAIL", context: context));
      Navigator.of(context).pushReplacementNamed(AppRouter.otpVerification);
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context));
    } catch (e) {
      print(e);
    }
  }

  Future verifyOTP({required String otp, required BuildContext context}) async {
    try {
      var userOTP = await _authenticationAPI.getOTPVerified(otp: otp);
      print(userOTP);
      final Map<String, dynamic> parseData = jsonDecode(userOTP.toString());
      bool isAuthenticated = parseData['status'];
      dynamic authData = ['token'];
      ScaffoldMessenger.of(context).showSnackBar(
          SnackUtil.stylishSnackBar(text: "OTP VERIFIED", context: context));
      Navigator.of(context).pushReplacementNamed(AppRouter.resetPass);

      // if (isAuthenticated) {
      //   WriteCache.setString(key: AppKeys.userVerifiedToken, value: authData)
      //       .whenComplete(() {
      //
      //   });
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       SnackUtil.stylishSnackBar(text: "Invail OTP", context: context));
      // }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context));
    } catch (e) {
      print(e);
    }
  }

  Future passwordReset({
    required String password,
    required BuildContext context,
  }) async {
    try {
      var userPassUpdate = await _authenticationAPI.getChangePassword(
          password: password, token: '');
      //         ReadCache.getString(key: AppKeys.userVerifiedToken).toString());
      // print(userPassUpdate);

      final Map<String, dynamic> parseData = jsonDecode(userPassUpdate);
      bool isAuthenticated = parseData['status'];
      ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
          text: "Password Updated", context: context));
      Navigator.of(context).pushReplacementNamed(AppRouter.loginRoute);
      // dynamic authData = parseData['token'];
      // if (isAuthenticated) {
      //   ReadCache.getString(key: AppKeys.userVerifiedToken).whenComplete(() {
      //
      //   });

      // ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
      //     text: "Password Updated", context: context));
      // Navigator.of(context).pushReplacementNamed(AppRouter.loginRoute);
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context));
    }
  }
}
