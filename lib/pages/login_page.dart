import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/components/app_color.dart';
import 'package:to_do_list_app/components/custom_button.dart';
import 'package:to_do_list_app/components/custom_textfield.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE0E0E0), Color(0xFFF5F5F5)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo langsung tanpa background putih
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset(
                      'assets/images/completed-task.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 40),

                  const Text(
                    "Dayflow",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    "Silakan masuk untuk melanjutkan",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),

                  CustomTextField(
                    hintText: "Username",
                    icon: Icons.person,
                    onChanged: (value) =>
                        authController.inputUsername.value = value,
                  ),
                  const SizedBox(height: 20),

                  CustomTextField(
                    hintText: "Password",
                    icon: Icons.lock,
                    obscureText: true,
                    onChanged: (value) =>
                        authController.inputPassword.value = value,
                  ),
                  const SizedBox(height: 30),

                  CustomButton(
                    text: "Login",
                    onPressed: () => authController.login(),
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
