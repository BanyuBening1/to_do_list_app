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
                  // Logo
                  Container(
                    width: 80,
                    height: 80,
                    child: Image.asset(
                      'assets/images/completed-task.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Title
                  const Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 8),
                    child: Text(
                      "Dayflow",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  const Text(
                    "Silakan masuk untuk melanjutkan",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),

                  // Username
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: CustomTextField(
                      hintText: "Username",
                      icon: Icons.person,
                      onChanged: (value) =>
                          authController.inputUsername.value = value,
                    ),
                  ),

                  // Password
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CustomTextField(
                      hintText: "Password",
                      icon: Icons.lock,
                      obscureText: true,
                      onChanged: (value) =>
                          authController.inputPassword.value = value,
                    ),
                  ),

                  // Button
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: CustomButton(
                      text: "Login",
                      onPressed: () => authController.login(),
                      textColor: Colors.white,
                    ),
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
