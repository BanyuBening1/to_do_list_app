
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_app/routes/routes.dart';

class LoginController extends GetxController {
 
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  login() async {
    if (usernameController.text.toString() == "admin" && passwordController.text.toString() == "admin") {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("username", usernameController.text.toString());
      Get.offAllNamed(AppRoute.dashboardPage);
      Get.snackbar("Login", "Login Successful");
    }
    else {
      Get.snackbar("Error", "invalid username or password");
    }
  }
}