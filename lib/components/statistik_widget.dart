// file: statistik_widget.dart
import 'package:flutter/material.dart';
import 'package:to_do_list_app/components/app_color.dart';

class StatistikWidget extends StatelessWidget {
  final int tinggi;
  final int sedang;
  final int rendah;
  final int total;

  const StatistikWidget({
    super.key,
    this.tinggi = 0,
    this.sedang = 0,
    this.rendah = 0,
    this.total = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Statistik Prioritas",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          _buildItem("Tinggi", tinggi),
          _buildItem("Sedang", sedang),
          _buildItem("Rendah", rendah),
          const Divider(height: 32),
          Text(
            "Total selesai: $total",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.secondary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String label, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text("$count", style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
