import 'package:flutter/material.dart';
import '../models/student.dart';
import 'student_item.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Student> students = [
      Student(
        firstName: 'Марія',
        lastName: 'Іванова',
        department: Department.finance,
        grade: 85,
        gender: Gender.female,
      ),
      Student(
        firstName: 'Дмитро',
        lastName: 'Петров',
        department: Department.it,
        grade: 90,
        gender: Gender.male,
      ),
      Student(
        firstName: 'Анна',
        lastName: 'Сидорова',
        department: Department.law,
        grade: 78,
        gender: Gender.female,
      ),
      Student(
        firstName: 'Іван',
        lastName: 'Кузнєцов',
        department: Department.medical,
        grade: 92,
        gender: Gender.male,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Студенти',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return StudentItem(
            student: student,
            onEdit: () {},
          );
        },
      ),
    );
  }
}