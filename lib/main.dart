import 'package:flutter/material.dart';
import 'widgets/students.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Список студентов',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      home: const StudentsScreen(),
    );
  }
}
