import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/login_controller.dart';

class Loginbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}