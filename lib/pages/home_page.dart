import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/components/app_color.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';
import 'package:to_do_list_app/routes/routes.dart';


class HomePage extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Todo"),
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.textLight,
        elevation: 4,
      ),
      body: Container(
        decoration: const BoxDecoration(color: AppColors.background),
        child: Column(
          children: [
            // Dropdown filter prioritas
           Padding(
              padding: const EdgeInsets.only(top: 16, left: 12, right: 12), // jarak dari AppBar lebih besar
              child: Align(
                alignment: Alignment.centerLeft, // biar gak full width
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 200, // atur lebar maksimum dropdown
                  ),
                  child: Obx(
                    () => DropdownButtonFormField<String>(
                      value: controller.filterPrioritas.value,
                      isDense: true,
                      decoration: InputDecoration(
                        labelText: "Filter Prioritas",
                        labelStyle: const TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        filled: true,
                        fillColor: AppColors.surface,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.secondary.withOpacity(0.6),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.secondary.withOpacity(0.6),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.secondary,
                            width: 2,
                          ),
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
                ),
              ),
            ),

            // Daftar Todo
            Expanded(
              child: Obx(() {
                if (controller.isTodoEmpty()) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.task_alt, size: 80, color: Colors.grey),
                        const SizedBox(height: 12),
                        const Text(
                          "Belum ada todo",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Tambahkan tugas baru dengan menekan tombol +",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                final todos = controller.getFilteredTodos();

                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    final priorityColor = controller.getPriorityColor(
                      todo['prioritas'],
                    );

                    return Card(
                      color: Colors.white.withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: ListTile(
                        title: Text(
                          todo['judul'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            decoration: todo['selesai'] == true
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              todo['deskripsi'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 12,
                              runSpacing: 4,
                              children: [
                                Text(
                                  "Kategori: ${todo['kategori']}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Prioritas: ${todo['prioritas']}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: priorityColor,
                                  ),
                                ),
                                if (todo['dueDate'] != null && todo['dueDate'] is DateTime)
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today,
                                        size: 14,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        controller.dateFormat.format(todo['dueDate']),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),

                              ],
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                              onPressed: () => controller.selesaikanTodo(index),
                            ),
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
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    content: Text("Yakin ingin menghapus todo '${todo['judul']}'?"),
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
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoute.addPage);
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
