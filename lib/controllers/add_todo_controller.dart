import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';
import 'package:to_do_list_app/db_helper.dart';
import 'package:to_do_list_app/models/todo.dart';

class AddTodoController extends GetxController {
  var judul = ''.obs;
  var deskripsi = ''.obs;
  var kategori = ''.obs;
  var priority = ''.obs;
  var dueDate = Rxn<DateTime>();

  final DbHelper dbHelper = DbHelper.instance;

  Future<void> pilihTanggal(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: dueDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      dueDate.value = pickedDate;
    }
  }

  void simpanTodo() async {
    if (judul.isEmpty ||
        deskripsi.isEmpty ||
        kategori.isEmpty ||
        priority.isEmpty ||
        dueDate.value == null) {
      Get.defaultDialog(title: "Error", middleText: "Semua field wajib diisi!");
      return;
    }

    final todo = Todo(
      judul: judul.value,
      deskripsi: deskripsi.value,
      kategori: kategori.value,
      prioritas: priority.value,
      dueDate: dueDate.value,
      selesai: false,
    );

    int id = await dbHelper.insertTodo(todo.toMap());
    todo.id = id;

    final home = Get.find<HomeController>();
    home.tambahTodo(todo);
    Get.back();
  }
}
