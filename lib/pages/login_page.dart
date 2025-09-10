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
      backgroundColor: AppColors.background,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.white.withOpacity(0.9),
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary, 
                        ),
                      ),
                      const SizedBox(height: 40),

                      
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
                        textColor: AppColors.textDark,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
