import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_app/controllers/resposive_controller.dart';
import 'package:to_do_list_app/pages/Responsive%20UI/Edit/edit_mobile.dart';
import 'package:to_do_list_app/pages/Responsive%20UI/Edit/edit_wide.dart';

class EditPage extends StatelessWidget {
  EditPage({super.key});

  final ResponsiveController responsiveController =
      Get.find<ResponsiveController>();

  final dateFormat = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        responsiveController.updateLayout(constraints);
        return Obx(
          () => responsiveController.isMobile.value ? EditMobile() : EditWide(),
        );
      },
    );
  }
}
