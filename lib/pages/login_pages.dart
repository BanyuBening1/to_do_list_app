import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/components/custom_button.dart';
import 'package:to_do_list_app/components/custom_textfield.dart';
import 'package:to_do_list_app/controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
 LoginPage({super.key});

  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
            ]
          ),
        ),
      ),
    );
  }
}