import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/components/custom_button.dart';
import 'package:to_do_list_app/components/custom_textfield.dart';
import 'package:to_do_list_app/controllers/auth_controller.dart';

class LoginWideScreen extends StatelessWidget {
  LoginWideScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // --------------------------------------------------
          // Sisi kiri: Ilustrasi atau branding
          // --------------------------------------------------
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/completed-task.png',
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Dayflow",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Kelola aktivitas harianmu dengan mudah",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // --------------------------------------------------
          // Sisi kanan: Form login
          // --------------------------------------------------
          Expanded(
            flex: 2,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.all(32),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Login ke Akun Anda",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Username
                        CustomTextField(
                          hintText: "Username",
                          icon: Icons.person,
                          onChanged: (value) =>
                              authController.inputUsername.value = value,
                        ),

                        const SizedBox(height: 20),

                        // Password
                        CustomTextField(
                          hintText: "Password",
                          icon: Icons.lock,
                          obscureText: true,
                          onChanged: (value) =>
                              authController.inputPassword.value = value,
                        ),

                        const SizedBox(height: 30),

                        // Tombol Login
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
          ),
        ],
      ),
    );
  }
}
