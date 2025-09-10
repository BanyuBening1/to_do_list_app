import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/home_controller.dart';

class AddTodoController extends GetxController {
  var judul = ''.obs;
  var deskripsi = ''.obs;
  var kategori = ''.obs;
  var priority = ''.obs;
  var dueDate = Rxn<DateTime>();

  void simpanTodo() {
    if (judul.isEmpty ||
        deskripsi.isEmpty ||
        kategori.isEmpty ||
        priority.isEmpty ||
        dueDate.value == null) {
      Get.defaultDialog(title: "Error", middleText: "Semua field wajib diisi!");
      return;
    }

    final newTodo = {
      "judul": judul.value,
      "deskripsi": deskripsi.value,
      "kategori": kategori.value,
      "prioritas": priority.value,
      "dueDate": dueDate.value,
      "selesai": false,
    };

    final home = Get.find<HomeController>();
    print("Tambah todo ke HomeController hash: ${home.hashCode}"); // 🔍 debug
    home.tambahTodo(newTodo);

    Get.back();
  }
}
