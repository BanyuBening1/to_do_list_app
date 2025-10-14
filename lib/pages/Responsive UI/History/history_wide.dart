import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/components/app_color.dart';
import 'package:to_do_list_app/components/statistik_widget.dart';
import 'package:to_do_list_app/controllers/history_controller.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';
import 'package:to_do_list_app/models/todo.dart';

class HistoryPageWide extends StatelessWidget {
  final HistoryController controller = Get.find<HistoryController>();
  final HomeController homeController = Get.find<HomeController>();

  HistoryPageWide({super.key});

  @override
  Widget build(BuildContext context) {
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
          final historyTodos = controller.historyTodos;

          return Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: historyTodos.isEmpty
                      ? const Center(
                          child: Text(
                            "Belum ada history",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: historyTodos.length,
                          itemBuilder: (context, index) {
                            final Todo todo = historyTodos[index];
                            final Color priorityColor = homeController
                                .getPriorityColor(todo.prioritas);

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
                                  todo.judul,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        todo.deskripsi,
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
                                              color: priorityColor.withOpacity(
                                                0.3,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              todo.prioritas,
                                              style: TextStyle(
                                                color: priorityColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Color(0xFFF08787),
                                            ),
                                            onPressed: () {
                                              Get.dialog(
                                                AlertDialog(
                                                  title: const Text(
                                                    "Konfirmasi",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  content: Text(
                                                    "Yakin ingin menghapus '${todo.judul}' dari history?",
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Get.back(),
                                                      child: const Text(
                                                        "Batal",
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      style:
                                                          ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors
                                                                    .redAccent,
                                                            foregroundColor:
                                                                Colors.white,
                                                          ),
                                                      onPressed: () {
                                                        controller
                                                            .deleteHistory(
                                                              todo.id!,
                                                            );
                                                        Get.back();
                                                        Get.snackbar(
                                                          "Terhapus",
                                                          "History '${todo.judul}' dihapus",
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM,
                                                        );
                                                      },
                                                      child: const Text(
                                                        "Ya, Hapus",
                                                      ),
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
              Container(
                width: 320,
                margin: const EdgeInsets.all(24),
                child: StatistikWidget(
                  total: historyTodos.length,
                  tinggi: controller.tinggi,
                  sedang: controller.sedang,
                  rendah: controller.rendah,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
