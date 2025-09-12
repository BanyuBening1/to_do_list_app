import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';

class HistoryController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();
  

  List<Map<String, dynamic>> get historyTodos => homeController.history;

  void deleteHistory(int index) {
    homeController.history.removeAt(index);
  }
}
