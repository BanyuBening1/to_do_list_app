import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/components/app_color.dart';
import 'package:to_do_list_app/controllers/history_controller.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';
import 'package:to_do_list_app/controllers/resposive_controller.dart';
import 'package:to_do_list_app/pages/Responsive%20UI/History/history_mobile.dart';
import 'package:to_do_list_app/pages/Responsive%20UI/History/history_wide.dart';

class HistoryPage extends StatelessWidget {
    final ResponsiveController responsiveController =
      Get.find<ResponsiveController>();

  final HistoryController controller = Get.find<HistoryController>();
  final HomeController homeController = Get.find<HomeController>();

  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        responsiveController.updateLayout(constraints);
        return Obx(
          () => responsiveController.isMobile.value ? HistoryMobile() : HistoryPageWide(),
        );
      },
    );
    }
}
