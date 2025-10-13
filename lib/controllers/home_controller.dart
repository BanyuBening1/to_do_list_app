import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_app/db_helper.dart';

class HomeController extends GetxController {
  var todos = <Map<String, dynamic>>[].obs;
  var history = <Map<String, dynamic>>[].obs;

  var filterPrioritas = "Semua".obs;

  final dateFormat = DateFormat('dd-MM-yyyy');
  final DbHelper dbHelper = DbHelper.instance;

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  void loadTodos() async {
    final data = await dbHelper.getTodos();
    todos.assignAll(
      data.map((todo) {
        final mutableTodo = Map<String, dynamic>.from(
          todo,
        ); // salinan agar bisa diubah
        if (mutableTodo['dueDate'] != null &&
            mutableTodo['dueDate'] is String) {
          mutableTodo['dueDate'] = DateTime.tryParse(mutableTodo['dueDate']);
        }
        mutableTodo['selesai'] = mutableTodo['selesai'] == 1 ? true : false;
        return mutableTodo;
      }).toList(),
    );
  }

  void tambahTodo(Map<String, dynamic> todo) async {
    int id = await dbHelper.insertTodo({
      'judul': todo['judul'],
      'deskripsi': todo['deskripsi'],
      'kategori': todo['kategori'],
      'prioritas': todo['prioritas'],
      'dueDate': todo['dueDate']?.toIso8601String(),
      'selesai': 0,
    });
    final newTodo = Map<String, dynamic>.from(todo);
    newTodo['id'] = id;
    newTodo['selesai'] = false;
    todos.add(newTodo);
  }

  void hapusTodo(int index) async {
    int id = todos[index]['id'];
    await dbHelper.deleteTodo(id);
    todos.removeAt(index);
  }

  void selesaikanTodo(int index) async {
    final todo = Map<String, dynamic>.from(todos[index]);
    todo['selesai'] = true;
    history.add(todo);

    await dbHelper.updateTodo({
      'id': todo['id'],
      'judul': todo['judul'],
      'deskripsi': todo['deskripsi'],
      'kategori': todo['kategori'],
      'prioritas': todo['prioritas'],
      'dueDate': todo['dueDate']?.toIso8601String(),
      'selesai': 1,
    });

    todos.removeAt(index);
  }

  String? formatDueDate(dynamic rawDate) {
    if (rawDate == null) return null;

    DateTime? parsed;
    if (rawDate is DateTime) {
      parsed = rawDate;
    } else if (rawDate is String) {
      try {
        parsed = DateTime.parse(rawDate);
      } catch (_) {
        return null;
      }
    }

    return parsed != null ? dateFormat.format(parsed) : null;
  }

  bool isTodoEmpty() => todos.isEmpty;

  List<Map<String, dynamic>> getFilteredTodos() {
    if (filterPrioritas.value == "Semua") {
      return todos;
    }
    return todos.where((t) => t['prioritas'] == filterPrioritas.value).toList();
  }

  void changeFilter(String val) {
    filterPrioritas.value = val;
  }

  Color getPriorityColor(String prioritas) {
    switch (prioritas) {
      case "Tinggi":
        return Colors.red;
      case "Sedang":
        return Colors.orange;
      case "Rendah":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
