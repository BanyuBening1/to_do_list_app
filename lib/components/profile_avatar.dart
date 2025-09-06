import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imagePath; // path dari asset
  final String name;
  final String email;

  const ProfileAvatar({
    super.key,
    required this.imagePath,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(imagePath), // pakai AssetImage
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          email,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
