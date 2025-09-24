import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/splashscreen_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashscreenController>(() => SplashscreenController());
  }
}
