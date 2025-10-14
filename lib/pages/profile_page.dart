import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/components/app_color.dart';
import 'package:to_do_list_app/components/profile_avatar.dart';
import 'package:to_do_list_app/components/profile_item.dart';
import 'package:to_do_list_app/controllers/profilecontroller.dart';
import 'package:to_do_list_app/controllers/resposive_controller.dart';
import 'package:to_do_list_app/pages/Responsive%20UI/Profile/profile_mobile.dart';
import 'package:to_do_list_app/pages/Responsive%20UI/Profile/profile_wide.dart';




class ProfilePage extends StatelessWidget {
      final ResponsiveController responsiveController =
      Get.find<ResponsiveController>();
      
  ProfilePage({super.key});

  final ProfileController controller = Get.put(ProfileController());

   @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        responsiveController.updateLayout(constraints);
        return Obx(
          () => responsiveController.isMobile.value ? ProfileMobile() : ProfileWideScreen(),
        );
      },
    );
    }
}
