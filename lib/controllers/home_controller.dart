import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_app/db_helper.dart';
import 'package:to_do_list_app/models/todo.dart';

class HomeController extends GetxController {
  var todos = <Todo>[].obs;
  var history = <Todo>[].obs;

  var filterPrioritas = "Semua".obs;

  final dateFormat = DateFormat('dd-MM-yyyy');
  final DbHelper dbHelper = DbHelper.instance;

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  Future<void> loadTodos() async {
    final data = await dbHelper.getTodos();

    final activeTodos = data.where((t) => t.selesai == false).toList();
    final completedTodos = data.where((t) => t.selesai == true).toList();

    todos.assignAll(activeTodos);
    history.assignAll(completedTodos);
  }

  void tambahTodo(Todo todo) {
    todos.add(todo);
    todos.refresh();
  }

  Future<void> hapusTodo(int id) async {
    await dbHelper.deleteTodo(id);
    todos.removeWhere((todo) => todo.id == id);
    todos.refresh();
  }

  Future<void> selesaikanTodo(int id) async {
    try {
      final todoIndex = todos.indexWhere((t) => t.id == id);
      if (todoIndex == -1) return;

      final todo = todos[todoIndex];
      todo.selesai = true;

      await dbHelper.updateTodo({
        'id': todo.id,
        'judul': todo.judul,
        'deskripsi': todo.deskripsi,
        'kategori': todo.kategori,
        'prioritas': todo.prioritas,
        'dueDate': todo.dueDate?.toIso8601String(),
        'selesai': 1,
      });

      todos.removeAt(todoIndex);
      history.add(todo);

      todos.refresh();
      history.refresh();
    } catch (e) {}
  }

  bool isTodoEmpty() => todos.isEmpty;

  List<Todo> getFilteredTodos() {
    if (filterPrioritas.value == "Semua") return todos;
    return todos.where((t) => t.prioritas == filterPrioritas.value).toList();
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
