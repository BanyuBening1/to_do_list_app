import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_app/routes/routes.dart';

class ProfileController extends GetxController {
  /// fungsi logout + hapus data
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    // 🔹 Hapus data tertentu
    await prefs.remove('username');
    await prefs.remove('email');
    await prefs.remove('phone');

    // 🔹 Atau hapus semua data
    // await prefs.clear();

    // Arahkan ke halaman login
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoute.splashPage,
      (route) => false,
    );
  }
}
