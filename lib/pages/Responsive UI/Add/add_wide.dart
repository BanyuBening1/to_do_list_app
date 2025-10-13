import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_app/components/app_color.dart';
import 'package:to_do_list_app/components/custom_button.dart';
import 'package:to_do_list_app/components/custom_dropdown.dart';
import 'package:to_do_list_app/components/custom_textfield.dart';
import 'package:to_do_list_app/controllers/add_todo_controller.dart';

class AddWide extends StatelessWidget {
  AddWide({super.key});

  final AddTodoController controller = Get.find<AddTodoController>();
  final dateFormat = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Todo"),
        backgroundColor: AppColors.secondary,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    const Text(
                      "Tambah Todo Baru",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Isi detail tugas yang ingin Anda tambahkan",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const Divider(height: 40),

                    // Form Dua Kolom
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Kolom Kiri
                        Expanded(
                          child: Column(
                            children: [
                              CustomTextField(
                                hintText: "Judul",
                                icon: Icons.title,
                                onChanged: (val) =>
                                    controller.judul.value = val,
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                hintText: "Deskripsi",
                                icon: Icons.description,
                                onChanged: (val) =>
                                    controller.deskripsi.value = val,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32),

                        // Kolom Kanan
                        Expanded(
                          child: Column(
                            children: [
                              Obx(
                                () => CustomDropdown(
                                  hintText: "Pilih Kategori",
                                  items: const [
                                    "Pekerjaan",
                                    "Sekolah",
                                    "Pribadi",
                                    "Umum",
                                  ],
                                  value: controller.kategori.value.isEmpty
                                      ? null
                                      : controller.kategori.value,
                                  onChanged: (val) {
                                    if (val != null) {
                                      controller.kategori.value = val;
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              Obx(
                                () => CustomDropdown(
                                  hintText: "Pilih Prioritas",
                                  items: const ["Tinggi", "Sedang", "Rendah"],
                                  value: controller.priority.value.isEmpty
                                      ? null
                                      : controller.priority.value,
                                  onChanged: (val) {
                                    if (val != null) {
                                      controller.priority.value = val;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Pilih Tanggal
                    Obx(
                      () => InkWell(
                        onTap: () => controller.pilihTanggal(context),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.secondary.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Tanggal Jatuh Tempo",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      controller.dueDate.value == null
                                          ? "Pilih tanggal jatuh tempo"
                                          : dateFormat.format(
                                              controller.dueDate.value!,
                                            ),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: controller.dueDate.value == null
                                            ? Colors.grey
                                            : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.secondary,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Tombol Aksi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Get.back(),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            side: BorderSide(color: Colors.grey.shade400),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Batal",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 16),
                        CustomButton(
                          text: "Simpan Todo",
                          onPressed: controller.simpanTodo,
                          backgroundColor: AppColors.secondary,
                          textColor: Colors.white,
                          expandWidth: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
