import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/add_todo_controller.dart';
import 'package:to_do_list_app/controllers/dashboard_controller.dart';
import 'package:to_do_list_app/controllers/history_controller.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put<HomeController>(HomeController(), permanent: true);
    Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<AddTodoController>(() => AddTodoController(), fenix: true);
    Get.lazyPut<HistoryController>(() => HistoryController(), fenix: true);
  }
}

