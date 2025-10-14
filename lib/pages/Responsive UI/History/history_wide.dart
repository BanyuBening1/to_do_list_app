import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/components/app_color.dart';
import 'package:to_do_list_app/controllers/history_controller.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';

class HistoryPageWide extends StatelessWidget {
  final HistoryController controller = Get.find<HistoryController>();
  final HomeController homeController = Get.find<HomeController>();

  HistoryPageWide({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Tugas Selesai"),
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.textLight,
        elevation: 4,
      ),
      body: Container(
        color: AppColors.background,
        child: Obx(() {
          final todos = controller.historyTodos;

          if (todos.isEmpty) {
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

          // layout responsive
          if (isWide) {
            return Row(
              children: [
                // ======= PANEL KIRI (DAFTAR HISTORY) =======
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        final priorityColor = homeController.getPriorityColor(
                          todo['prioritas'],
                        );

                        return Card(
                          color: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            title: Text(
                              todo['judul'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    todo['deskripsi'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: priorityColor.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          todo['prioritas'],
                                          style: TextStyle(
                                            color: priorityColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Color(0xFFF08787)),
                                        onPressed: () {
                                          Get.dialog(
                                            AlertDialog(
                                              title: const Text(
                                                "Konfirmasi",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              content: Text(
                                                  "Yakin ingin menghapus '${todo['judul']}' dari history?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Get.back(),
                                                  child: const Text("Batal"),
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                    foregroundColor:
                                                        Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    controller.deleteHistory(
                                                        index);
                                                    Get.back();
                                                    Get.snackbar(
                                                      "Terhapus",
                                                      "History '${todo['judul']}' dihapus",
                                                      snackPosition:
                                                          SnackPosition.BOTTOM,
                                                    );
                                                  },
                                                  child: const Text("Ya, Hapus"),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // ======= PANEL KANAN (STATISTIK) =======
                Container(
                  width: 320,
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Statistik Prioritas",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildStatItem(
                          "Tinggi",
                          todos
                              .where((t) => t['prioritas'] == "Tinggi")
                              .length,
                          Colors.redAccent),
                      _buildStatItem(
                          "Sedang",
                          todos
                              .where((t) => t['prioritas'] == "Sedang")
                              .length,
                          Colors.orangeAccent),
                      _buildStatItem(
                          "Rendah",
                          todos
                              .where((t) => t['prioritas'] == "Rendah")
                              .length,
                          Colors.green),
                      const Divider(height: 32),
                      Text(
                        "Total selesai: ${todos.length}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          // ======= LAYOUT MOBILE =======
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              final priorityColor =
                  homeController.getPriorityColor(todo['prioritas']);
              return Card(
                color: Colors.white.withOpacity(0.9),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  title: Text(
                    todo['judul'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
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
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Color(0xFFF08787)),
                    onPressed: () {
                      Get.dialog(
                        AlertDialog(
                          title: const Text(
                            "Konfirmasi",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: Text(
                              "Yakin ingin menghapus '${todo['judul']}' dari history?"),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text("Batal"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                controller.deleteHistory(index);
                                Get.back();
                                Get.snackbar(
                                  "Terhapus",
                                  "History '${todo['judul']}' dihapus",
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                              child: const Text("Ya, Hapus"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildStatItem(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "$count",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
