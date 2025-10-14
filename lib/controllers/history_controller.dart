import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';
import 'package:to_do_list_app/db_helper.dart';
import 'package:to_do_list_app/models/todo.dart';

class HistoryController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();
  final DbHelper dbHelper = DbHelper.instance;

  List<Todo> get historyTodos => homeController.history;

  int get tinggi => historyTodos.where((t) => t.prioritas == "Tinggi").length;
  int get sedang => historyTodos.where((t) => t.prioritas == "Sedang").length;
  int get rendah => historyTodos.where((t) => t.prioritas == "Rendah").length;

  Future<void> deleteHistory(int id) async {
    int result = await dbHelper.deleteTodo(id);
    homeController.history.removeWhere((todo) => todo.id == id);
    homeController.history.refresh();
  }
}
