import 'package:flutter/material.dart';
import '../components/profile_avatar.dart';
import '../components/profile_item.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            const ProfileAvatar(
              imagePath: "assets/images/unyub.HEIC",
              name: "Banyu Alip",
              email: "banyu.alip@test.com",
            ),
            const SizedBox(height: 30),

            
            const ProfileItem(icon: Icons.phone, text: "+62 812 3456 7890"),
            const ProfileItem(icon: Icons.location_on, text: "Kudus, Indonesia"),
            const ProfileItem(icon: Icons.work, text: "Flutter Developer")
          ],
        ),
      ),
    );
  }
}
