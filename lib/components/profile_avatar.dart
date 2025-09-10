import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imagePath;
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
          radius: 55,
          backgroundColor: const Color(0xFF708993),
          backgroundImage: AssetImage(imagePath),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
