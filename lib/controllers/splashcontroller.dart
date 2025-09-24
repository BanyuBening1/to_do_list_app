import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_app/routes/routes.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {

    super.onInit();
    checklogin();
  }

  checklogin() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 3));
    if (prefs.getString("username") != null) {
     Get.offAllNamed(AppRoute.dashboardPage);
    } else {
      Get.offAllNamed(AppRoute.loginPage);
      //route belum jadi
    }
  }
}