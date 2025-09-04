import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/routes/routes.dart';

class AuthController extends GetxController {
  var inputUsername = ''.obs;
  var inputPassword = ''.obs;

  final String username = "banyu";
  final String password = "alip";

  void login() {
    // cek input kosong
    if (inputUsername.isEmpty || inputPassword.isEmpty) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Username dan Password harus diisi",
        textConfirm: "OK",
        onConfirm: () => Get.back(),
      );
      return;
    }

    // cek username & password
    if (inputUsername.value == username && inputPassword.value == password) {
      // pindah ke dashboard
      Get.offNamed(AppRoute.dashboardPage);
      print("Login Berhasil");
    } else {
      // dialog gagal
      Get.defaultDialog(
        title: "Login Gagal",
        middleText: "Username atau password salah",
        textConfirm: "Coba Lagi",
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
}
