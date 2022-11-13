import 'dart:developer';

import 'package:vnmo_mis/model/login_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../layout.dart';
import '../service/authentication_service.dart';
import '../service/storage/constant_name.dart';
import '../widgets/snackbars.dart';

class AuthenticationController extends GetxController {
  final String error = "Internal Server Error";
  final AuthenticationService _authenticationService = AuthenticationService();
  TextEditingController usernameTxt = TextEditingController();
  TextEditingController passwordTxt = TextEditingController();
  var isLoading = false.obs;

  void getLoginAdmin() async {
    isLoading.value = true;
    LoginResponse loginResponse = await _authenticationService
        .authenticationLogin(
            username: usernameTxt.text, password: passwordTxt.text)
        .catchError((onError) {
      Future.delayed(const Duration(milliseconds: 500), () {
        isLoading.value = false;
      });
      const SnackBars().snackBarFail("Unable to login", "");
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });

    if (loginResponse.result == 1) {
      Get.offAll(() => SiteLayout());
      //storage data
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(ConstantName().username, loginResponse.data?.username ?? '');
      await prefs.setInt(ConstantName().apId, loginResponse.data?.userApId ?? 0);
      await prefs.setString(ConstantName().apName, loginResponse.data?.userApName ?? '');
      await prefs.setInt(ConstantName().year, loginResponse.data?.year ?? 1990);
      await prefs.setInt(ConstantName().inputTarget, loginResponse.data?.inputTarget ?? 0);

    } else if(loginResponse.result == 0){
      const SnackBars().snackBarFail(loginResponse.message.toString(), "");
    } else{
      const SnackBars().snackBarFail(error, "");
    }
  }
}
