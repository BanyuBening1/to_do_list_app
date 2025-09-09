import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var todos = <Map<String, dynamic>>[].obs;
  var history = <Map<String, dynamic>>[].obs;

  var filterPrioritas = "Semua".obs;

  void tambahTodo(Map<String, dynamic> todo) {
    todos.add({
      'judul': todo['judul'],
      'deskripsi': todo['deskripsi'],
      'kategori': todo['kategori'],
      'prioritas': todo['prioritas'],
      'selesai': false,
    });
  }

  void hapusTodo(int index) {
    todos.removeAt(index);
  }

  void selesaikanTodo(int index) {
    final todo = todos[index];
    todo['selesai'] = true;
    history.add(todo); // pindah ke history
    todos.removeAt(index); // hapus dari list aktif
  }

  Widget emptyMessage() {
    return const Center(
      child: Text("Belum ada todo", style: TextStyle(fontSize: 16)),
    );
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
