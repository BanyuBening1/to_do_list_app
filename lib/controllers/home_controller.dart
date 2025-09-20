import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  var todos = <Map<String, dynamic>>[].obs;
  var history = <Map<String, dynamic>>[].obs;

  var filterPrioritas = "Semua".obs;

  final dateFormat = DateFormat('dd-MM-yyyy');

 

  void tambahTodo(Map<String, dynamic> todo) {
    todos.add({
      'judul': todo['judul'],
      'deskripsi': todo['deskripsi'],
      'kategori': todo['kategori'],
      'prioritas': todo['prioritas'],
      'dueDate': todo['dueDate'],  
      'selesai': false,
    });
  }

  void hapusTodo(int index) {
    todos.removeAt(index);
  }

  void selesaikanTodo(int index) {
    final todo = todos[index];
    todo['selesai'] = true;
    history.add(todo);
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
