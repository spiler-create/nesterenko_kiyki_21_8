import 'package:flutter/material.dart';

class Department {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  Department({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

final departments = [
  Department(
    id: 'finance',
    name: 'Фінанси',
    icon: Icons.attach_money,
    color: Colors.greenAccent,
  ),
  Department(
    id: 'law',
    name: 'Юриспруденція',
    icon: Icons.gavel,
    color: Colors.blueAccent,
  ),
  Department(
    id: 'it',
    name: 'ІТ',
    icon: Icons.computer,
    color: Colors.tealAccent,
  ),
  Department(
    id: 'medical',
    name: 'Медицина',
    icon: Icons.local_hospital,
    color: Colors.redAccent,
  ),
];
