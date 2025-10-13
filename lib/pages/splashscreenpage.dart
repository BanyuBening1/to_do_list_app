import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashscreenPage extends StatelessWidget {
   SplashscreenPage({super.key});

    final SplashscreenController = Get.find<SplashscreenPage>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        child: Text("Splash Screen"),
      ),),
    );
  }
}