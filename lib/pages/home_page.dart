import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/components/app_color.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';
import 'package:to_do_list_app/routes/routes.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  HomePage({super.key});

  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Todo"),
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        elevation: 4,
      ),
      body: Container(
        decoration: const BoxDecoration(color: AppColors.background),
        child: Column(
          children: [
            // Dropdown filter prioritas
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.filterPrioritas.value,
                  decoration: InputDecoration(
                    labelText: "Filter Prioritas",
                    labelStyle: const TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
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

            // Daftar Todo
            Expanded(
              child: Obx(() {
                if (controller.isTodoEmpty()) {
                  return const Center(
                    child: Text(
                      "Belum ada todo",
                      style: TextStyle(fontSize: 16),
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
                                if (todo['dueDate'] != null &&
                                    todo['dueDate'] is DateTime)
                                  Text(
                                    "Due: ${controller.dateFormat.format(todo['dueDate'])}", // ✅ pakai dari controller
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w500,
                                    ),
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
                              onPressed: () => controller.hapusTodo(index),
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
