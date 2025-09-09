import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var todos = <Map<String, dynamic>>[].obs;
  var filterPrioritas = "Semua".obs;

  void tambahTodo(Map<String, dynamic> todo) {
    todos.add({
      'judul': todo['judul'] ?? '',
      'deskripsi': todo['deskripsi'] ?? '',
      'kategori': todo['kategori'] ?? 'Umum',
      'prioritas': todo['prioritas'] ?? 'Rendah', // ambil sesuai input
      'selesai': false,
    });
  }

  void hapusTodo(int index) {
    todos.removeAt(index);
  }

  void selesaikanTodo(int index) {
    todos[index]['selesai'] = true;
    todos.refresh();
  }

  Widget emptyMessage() {
    return const Center(
      child: Text("Belum ada todo", style: TextStyle(fontSize: 16)),
    );
  }

  bool isTodoEmpty() => todos.isEmpty;

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

  List<Map<String, dynamic>> getFilteredTodos() {
    if (filterPrioritas.value == "Semua") return todos;
    return todos
        .where((todo) => todo['prioritas'] == filterPrioritas.value)
        .toList();
  }

  void changeFilter(String value) {
    filterPrioritas.value = value;
  }
}
