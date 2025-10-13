import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';
import 'package:to_do_list_app/db_helper.dart';

class EditController extends GetxController {
  late int index;
  late Map<String, dynamic> todo;
  final HomeController homeController = Get.find<HomeController>();
  final DbHelper dbHelper = DbHelper.instance;

  final judulController = TextEditingController();
  final deskripsiController = TextEditingController();
  var kategori = ''.obs;
  var priority = ''.obs;
  var dueDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    index = Get.arguments as int;
    todo = Map.from(homeController.todos[index]);

    judulController.text = todo['judul'];
    deskripsiController.text = todo['deskripsi'];
    kategori.value = todo['kategori'];
    priority.value = todo['prioritas'];
    dueDate.value = todo['dueDate'];
  }

  Future<void> pilihTanggal(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: dueDate.value ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      dueDate.value = pickedDate;
    }
  }

  Future<void> updateTodo() async {
    if (judulController.text.isEmpty ||
        deskripsiController.text.isEmpty ||
        kategori.value.isEmpty ||
        priority.value.isEmpty ||
        dueDate.value == null) {
      Get.defaultDialog(title: "Error", middleText: "Semua field wajib diisi!");
      return;
    }

    final updatedTodo = {
      'id': todo['id'],
      'judul': judulController.text,
      'deskripsi': deskripsiController.text,
      'kategori': kategori.value,
      'prioritas': priority.value,
      'dueDate': dueDate.value?.toIso8601String(),
      'selesai': todo['selesai'] == true ? 1 : 0,
    };

    await dbHelper.updateTodo(updatedTodo);

    homeController.todos[index] = {
      ...updatedTodo,
      'selesai': todo['selesai'] == true,
      'dueDate': dueDate.value,
    };
    homeController.todos.refresh();

    Get.back();
  }

  @override
  void onClose() {
    judulController.dispose();
    deskripsiController.dispose();
    super.onClose();
  }
}
