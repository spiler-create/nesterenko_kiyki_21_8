import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentItem extends StatelessWidget {
  final Student student;
  final VoidCallback onEdit;

  const StudentItem({
    super.key,
    required this.student,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final gradientColors = student.gender == Gender.male
        ? [Colors.blue.shade100, Colors.lightBlue.shade300]
        : [Colors.pink.shade100, Colors.red.shade300];
    final iconColor = student.gender == Gender.male ? Colors.blue : Colors.red;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradientColors.last.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12),
              color: iconColor.withOpacity(0.1),
            ),
            alignment: Alignment.center,
            child: Icon(
              student.department.icon,
              size: 30,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${student.firstName} ${student.lastName}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Факультет: ${student.department.name}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                '${student.grade}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              IconButton(
                icon: const Icon(Icons.edit_square, size: 20),
                color: Colors.black,
                onPressed: onEdit,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
