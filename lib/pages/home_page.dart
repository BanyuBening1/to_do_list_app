import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';
import 'package:to_do_list_app/routes/routes.dart';

class HomePage extends StatelessWidget {
  // final HomeController controller = Get.find<HomeController>();
  final HomeController controller = Get.put(HomeController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Todo"), centerTitle: true),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => DropdownButtonFormField<String>(
                value: controller.filterPrioritas.value,
                decoration: InputDecoration(
                  labelText: "Filter Prioritas",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
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

          Expanded(
            child: Obx(() {
              if (controller.isTodoEmpty()) {
                return controller.emptyMessage();
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
                            onPressed: () => controller.selesaikanTodo(
                              controller.todos.indexOf(todo),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => controller.hapusTodo(
                              controller.todos.indexOf(todo),
                            ),
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

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoute.addPage);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
