import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/components/custom_button.dart';
import 'package:to_do_list_app/components/custom_textfield.dart';
import 'package:to_do_list_app/controllers/resposive_controller.dart';
import 'package:to_do_list_app/pages/Responsive%20UI/Login/login_mobile.dart';
import 'package:to_do_list_app/pages/Responsive%20UI/Login/login_wide.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
    final ResponsiveController responsiveController =
      Get.find<ResponsiveController>();
  
  LoginPage({super.key});

  final AuthController authController = Get.find<AuthController>();

     @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        responsiveController.updateLayout(constraints);
        return Obx(
          () => responsiveController.isMobile.value ? LoginMobile() : LoginWideScreen(),
        );
      },
    );
    }
}