import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_app/components/app_color.dart';
import 'package:to_do_list_app/components/custom_button.dart';
import 'package:to_do_list_app/components/custom_dropdown.dart';
import 'package:to_do_list_app/components/custom_textfield.dart';
import 'package:to_do_list_app/controllers/edit_controller.dart';

class EditMobile extends StatelessWidget {
  EditMobile({super.key});

  final EditController controller = Get.find<EditController>();
  final dateFormat = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Todo"),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                hintText: "Judul",
                icon: Icons.title,
                controller: controller.judulController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: "Deskripsi",
                icon: Icons.description,
                controller: controller.deskripsiController,
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
                () => Row(
                  children: [
                    Expanded(
                      child: Text(
                        controller.dueDate.value == null
                            ? "Belum memilih tanggal"
                            : "Tanggal: ${dateFormat.format(controller.dueDate.value!)}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      onPressed: () => controller.pilihTanggal(context),
                      icon: const Icon(Icons.calendar_today),
                      color: AppColors.secondary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              CustomButton(
                text: "Simpan Perubahan",
                onPressed: controller.updateTodo,
                backgroundColor: AppColors.secondary,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
