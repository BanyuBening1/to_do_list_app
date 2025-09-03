import 'package:get/get.dart';

class AuthController extends GetxController {
  var inputUsername = ''.obs;
  var inputPassword = ''.obs;

  final String username = "banyu";
  final String password = "alip";

  void login() {
    // cek input kosong
    if (inputUsername.isEmpty || inputPassword.isEmpty) {
      Get.snackbar(
        "Error",
        "Username dan Password harus diisi",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (inputUsername.value == username && inputPassword.value == password) {
      // Get.offNamed('/dashboard');
      print("Login Berhasil");
    } else {
      Get.snackbar(
        "Login Gagal",
        "Username atau password salah",
        snackPosition: SnackPosition.BOTTOM,
      );
      inputPassword.value = ""; 
    }
  }
}
