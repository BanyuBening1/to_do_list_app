import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/history_controller.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';

class HistoryPage extends StatelessWidget {
  final HistoryController controller = Get.find<HistoryController>();
  final HomeController homeController = Get.find<HomeController>();

  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("History"), centerTitle: true),
      body: Obx(() {
        if (controller.historyTodos.isEmpty) {
          return const Center(child: Text("Belum ada history"));
        }

        return ListView.builder(
          itemCount: controller.historyTodos.length,
          itemBuilder: (context, index) {
            final todo = controller.historyTodos[index];
            final priorityColor = homeController.getPriorityColor(
              todo['prioritas'],
            );

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                title: Text(
                  todo['judul'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(todo['deskripsi']),
                trailing: Text(
                  todo['prioritas'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: priorityColor,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
