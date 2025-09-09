import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';
import 'package:to_do_list_app/controllers/add_todo_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AddTodoController>(() => AddTodoController());
  }
}
