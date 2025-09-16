import 'package:flutter/material.dart';
import 'package:to_do_list_app/components/app_color.dart';
import '../components/profile_avatar.dart';
import '../components/profile_item.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
           color:AppColors.background,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                
                Card(
                  color:AppColors.secondary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: const ProfileAvatar(
                      imagePath: "assets/images/unyub.HEIC",
                      name: "Banyu Alip",
                      email: "banyu.alip@example.com",
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                Card(
                color: AppColors.secondary, 
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: const ProfileItem(
                  icon: Icons.phone,
                  text: "+62 812 3456 7890",
                ),
              ),
              Card(
                color: AppColors.secondary, 
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: const ProfileItem(
                  icon: Icons.location_on,
                  text: "Kudus, Indonesia",
                ),
              ),
              Card(
                color: AppColors.secondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: const ProfileItem(
                  icon: Icons.work,
                  text: "Pelajar",
                ),
              ),
              const SizedBox(height: 25),

                

              ],
            ),
          ),
        ),
      ),
    );
  }
}
