import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/reusable/custom_button.dart';
import 'package:to_do_list_app/reusable/custom_textfield.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              // Username pakai CustomTextField
              CustomTextField(
                hintText: "Username",
                icon: Icons.person,
                onChanged: (value) =>
                    authController.inputUsername.value = value,
              ),
              const SizedBox(height: 20),

              // Password pakai CustomTextField
              CustomTextField(
                hintText: "Password",
                icon: Icons.lock,
                obscureText: true,
                onChanged: (value) =>
                    authController.inputPassword.value = value,
              ),
              const SizedBox(height: 30),

              // Custom Button
              CustomButton(
                text: "Login",
                onPressed: () => authController.login(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
