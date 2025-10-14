import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';
import 'package:to_do_list_app/db_helper.dart';
import 'package:to_do_list_app/models/todo.dart';

class EditController extends GetxController {
  late int todoId;
  late Todo todo;
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
    todoId = Get.arguments as int;
    todo = homeController.todos.firstWhere(
      (t) => t.id == todoId,
      orElse: () => throw Exception("Todo tidak ditemukan"),
    );

    judulController.text = todo.judul;
    deskripsiController.text = todo.deskripsi;
    kategori.value = todo.kategori;
    priority.value = todo.prioritas;
    dueDate.value = todo.dueDate;
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

    todo.judul = judulController.text;
    todo.deskripsi = deskripsiController.text;
    todo.kategori = kategori.value;
    todo.prioritas = priority.value;
    todo.dueDate = dueDate.value;

    await dbHelper.updateTodo(todo.toMap());

    int index = homeController.todos.indexWhere((t) => t.id == todoId);
    if (index != -1) {
      homeController.todos[index] = todo;
      homeController.todos.refresh();
    }

    Get.back();
  }

  @override
  void onClose() {
    judulController.dispose();
    deskripsiController.dispose();
    super.onClose();
  }
}
