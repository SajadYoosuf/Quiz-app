import 'package:flutter/material.dart';

Widget buildProfileProgressCard(
  BuildContext context,
  IconData icon,
  String value,
  String label, {
  List<Color> gradientColors = const [Colors.purple, Colors.pink],
}) {
  var width = MediaQuery.of(context).size.width;

  return Card(
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    child: Container(
      height: 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradientColors),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          SizedBox(width: width * 0.05),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                label,
                style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
