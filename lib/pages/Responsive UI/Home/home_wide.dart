import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/components/app_color.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';
import 'package:to_do_list_app/routes/routes.dart';

class HomeWideScreen extends StatelessWidget {
  HomeWideScreen({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------------------------------
            // Sidebar kiri: Filter & tombol tambah
            // -------------------------------
            Container(
              width: 280,
              height: double.infinity,
              padding: const EdgeInsets.all(20),
              color: AppColors.secondary.withOpacity(0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Daftar Todo",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 30),

                  Obx(
                    () => DropdownButtonFormField<String>(
                      value: controller.filterPrioritas.value,
                      decoration: InputDecoration(
                        labelText: "Filter Prioritas",
                        labelStyle: const TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        filled: true,
                        fillColor: AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      dropdownColor: AppColors.background,
                      items: const [
                        DropdownMenuItem(value: "Semua", child: Text("Semua")),
                        DropdownMenuItem(value: "Tinggi", child: Text("Tinggi")),
                        DropdownMenuItem(value: "Sedang", child: Text("Sedang")),
                        DropdownMenuItem(value: "Rendah", child: Text("Rendah")),
                      ],
                      onChanged: (val) {
                        if (val != null) controller.changeFilter(val);
                      },
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Get.toNamed(AppRoute.addPage),
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        "Tambah Todo",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // -------------------------------
            // Konten kanan: Daftar Todo
            // -------------------------------
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Obx(() {
                  if (controller.isTodoEmpty()) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.task_alt, size: 100, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            "Belum ada todo",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Tambahkan tugas baru dengan tombol di kiri",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }

                  final todos = controller.getFilteredTodos();

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 3.2,
                    ),
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      final priorityColor =
                          controller.getPriorityColor(todo['prioritas']);

                      return Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Judul + tombol hapus
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        todo['judul'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: AppColors.primary,
                                          decoration: todo['selesai'] == true
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                              icon: const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                              onPressed: () => controller.selesaikanTodo(index),
                            ),
                             IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Get.toNamed(AppRoute.editPage, arguments: index);
                              },
                            ),        
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Color(0xFFF08787)),
                               onPressed: () {
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text(
                                      "Konfirmasi",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Text(
                                      "Yakin ingin menghapus todo '${todo['judul']}'?",
                                    ),
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
                                          controller.hapusTodo(index);
                                          Get.back();
                                          Get.snackbar(
                                            "Terhapus",
                                            "Todo '${todo['judul']}' dihapus",
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
                                  ],
                                ),

                                const SizedBox(height: 8),

                                // Deskripsi
                                Text(
                                  todo['deskripsi'] ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14),
                                ),

                                const SizedBox(height: 8),

                                // Prioritas + tanggal
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Prioritas: ${todo['prioritas']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: priorityColor,
                                      ),
                                    ),
                                    if (todo['dueDate'] != null &&
                                        todo['dueDate'] is DateTime)
                                      Text(
                                        controller.dateFormat
                                            .format(todo['dueDate']),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
