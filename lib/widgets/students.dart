import 'package:flutter/material.dart';
import 'new_student.dart';
import 'student_item.dart';
import '../models/student.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  List<Student> students = [
    Student(
      id: '1',
      firstName: 'Марія',
      lastName: 'Іванова',
      department: Department.finance,
      grade: 85,
      gender: Gender.female,
    ),
    Student(
      id: '2',
      firstName: 'Дмитро',
      lastName: 'Петров',
      department: Department.it,
      grade: 90,
      gender: Gender.male,
    ),
  ];

  void showModalStudent({Student? student}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return NewStudent(
          student: student,
          onSave: (newStudent) {
            setState(() {
              if (student != null) {
                final index = students.indexOf(student);
                students[index] = newStudent;
              } else {
                students.add(newStudent);
              }
            });
          },
        );
      },
    );
  }

  void delElem(int index) {
    final removedStudent = students[index];
    setState(() {
      students.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedStudent.firstName} видалено'),
        action: SnackBarAction(
          label: 'Відмінити',
          onPressed: () {
            setState(() {
              students.insert(index, removedStudent);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Студенти'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Dismissible(
            key: ValueKey(student.id),
            onDismissed: (_) => delElem(index),
            child: InkWell(
              onTap: () => showModalStudent(student: student),
              child: StudentItem(
                student: student,
                onEdit: () => showModalStudent(student: student),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton.extended(
          label: const Text(
            'Додати',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          icon: const Icon(
            Icons.add,
            size: 20,
            color: Colors.white,
          ),
          backgroundColor: Colors.purpleAccent,
          onPressed: () => showModalStudent(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
