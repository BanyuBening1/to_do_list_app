import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/components/app_color.dart';
import 'package:to_do_list_app/controllers/history_controller.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';

class HistoryPage extends StatelessWidget {
  final HistoryController controller = Get.find<HistoryController>();
  final HomeController homeController = Get.find<HomeController>();

  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
        backgroundColor:AppColors.secondary, 
        foregroundColor: AppColors.textDark, 
        elevation: 4,
      ),

      
      body: Container(
        decoration: const BoxDecoration(
        color: AppColors.background
        ),
        child: Obx(() {
          if (controller.historyTodos.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada history",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark, 
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.historyTodos.length,
            itemBuilder: (context, index) {
              final todo = controller.historyTodos[index];
              final priorityColor = homeController.getPriorityColor(
                todo['prioritas'],
              );

              return Card(
                
                color: Colors.white.withOpacity(0.9),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  title: Text(
                    todo['judul'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:AppColors.primary, 
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      todo['deskripsi'],
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                   trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: priorityColor.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          todo['prioritas'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Color(0xFFF08787)),
                        onPressed: () {
                          controller.deleteHistory(index);
                          Get.snackbar(
                            "Terhapus",
                            "History '${todo['judul']}' dihapus",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
