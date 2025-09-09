import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';

class AddTodoController extends GetxController {
  var judul = ''.obs;
  var deskripsi = ''.obs;
  var kategori = ''.obs;
  var priority = ''.obs;

  void simpanTodo() {
    if (judul.isEmpty || deskripsi.isEmpty) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Judul dan deskripsi tidak boleh kosong!",
      );
      return;
    }

    final newTodo = {
      "judul": judul.value,
      "deskripsi": deskripsi.value,
      "kategori": kategori.value,
      "prioritas": priority.value, 
    };

    // kirim ke HomeController
    Get.find<HomeController>().tambahTodo(newTodo);

    Get.back(); 
  }
}
