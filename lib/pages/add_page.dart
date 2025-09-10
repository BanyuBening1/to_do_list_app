import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_app/components/app_color.dart';
import 'package:to_do_list_app/components/custom_button.dart';
import 'package:to_do_list_app/components/custom_dropdown.dart';
import 'package:to_do_list_app/components/custom_textfield.dart';
import 'package:to_do_list_app/controllers/add_todo_controller.dart';

class AddPage extends StatelessWidget {
  final AddTodoController controller = Get.find<AddTodoController>();

  AddPage({super.key});

  final dateFormat = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Tambah Todo"),
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                hintText: "Judul",
                icon: Icons.title,
                onChanged: (val) => controller.judul.value = val,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                hintText: "Deskripsi",
                icon: Icons.description,
                onChanged: (val) => controller.deskripsi.value = val,
              ),
              const SizedBox(height: 16),

              Obx(
                () => CustomDropdown(
                  hintText: "Pilih Kategori",
                  items: const ["Pekerjaan", "Sekolah", "Pribadi", "Umum"],
                  value: controller.kategori.value.isEmpty
                      ? null
                      : controller.kategori.value,
                  onChanged: (val) {
                    if (val != null) controller.kategori.value = val;
                  },
                ),
              ),
              const SizedBox(height: 16),

              Obx(
                () => CustomDropdown(
                  hintText: "Pilih Prioritas",
                  items: const ["Tinggi", "Sedang", "Rendah"],
                  value: controller.priority.value.isEmpty
                      ? null
                      : controller.priority.value,
                  onChanged: (val) {
                    if (val != null) controller.priority.value = val;
                  },
                ),
              ),
              const SizedBox(height: 16),

              Obx(
                () => ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: AppColors.secondary),
                  ),
                  leading: const Icon(
                    Icons.calendar_today,
                    color: AppColors.secondary,
                  ),
                  title: Text(
                    controller.dueDate.value == null
                        ? "Pilih Due Date"
                        : "Due: ${dateFormat.format(controller.dueDate.value!)}",
                    style: TextStyle(
                      color: controller.dueDate.value == null
                          ? Colors.grey
                          : AppColors.primary,
                    ),
                  ),
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      controller.dueDate.value = pickedDate;
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),

              CustomButton(
                text: "Simpan Todo",
                onPressed: controller.simpanTodo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
