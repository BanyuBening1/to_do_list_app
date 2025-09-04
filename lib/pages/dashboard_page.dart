import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/dashboard_controller.dart';
import 'home_page.dart';
import 'history_page.dart';
import 'profile_page.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  // Panggil controller
  final DashboardController controller = Get.find<DashboardController>();

  // Daftar halaman
  final List<Widget> pages = const [
    HomePage(), 
    HistoryPage(), 
    ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: pages[controller.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeTabIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "History",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
