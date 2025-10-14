import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';
import 'package:to_do_list_app/controllers/resposive_controller.dart';
import 'package:to_do_list_app/pages/Responsive%20UI/Home/home_mobile.dart';
import 'package:to_do_list_app/pages/Responsive%20UI/Home/home_wide.dart';


class HomePage extends StatelessWidget {
      final ResponsiveController responsiveController =
      Get.find<ResponsiveController>();
  final HomeController controller = Get.find<HomeController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        responsiveController.updateLayout(constraints);
        return Obx(
          () => responsiveController.isMobile.value ? HomeMobile() : HomeWideScreen(),
        );
      },
    );
    }
}
