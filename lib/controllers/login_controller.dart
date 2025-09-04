import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  void login() {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email dan password tidak boleh kosong",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    // simulasi proses login
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;

      if (email == "admin@gmail.com" && password == "12345") {
        Get.snackbar("Success", "Login berhasil",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Failed", "Email atau password salah",
            snackPosition: SnackPosition.BOTTOM);
      }
    });
  }
}
