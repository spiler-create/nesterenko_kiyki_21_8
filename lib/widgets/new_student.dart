import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/student.dart';
import '../models/department.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/students_provider.dart';

class NewStudent extends ConsumerStatefulWidget {
  const NewStudent({
    super.key,
    this.studentIndex
  });

  final int? studentIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewStudentState();
}

class _NewStudentState extends ConsumerState<NewStudent> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  Department? selectedDepartment;
  Gender? selectedGender;
  int grade = 50;

  @override
  void initState() {
    super.initState();
    if (widget.studentIndex != null) {
      final student = ref.read(studentsProvider)![widget.studentIndex!];
      firstNameController.text = student.firstName;
      lastNameController.text = student.lastName;
      grade = student.grade;
      selectedGender = student.gender;
      selectedDepartment = student.department;
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  void saveStudent() async {
    if (widget.studentIndex != null) {
      await ref.read(studentsProvider.notifier).insertStudent(
            widget.studentIndex!,
            firstNameController.text.trim(),
            lastNameController.text.trim(),
            selectedDepartment,
            selectedGender,
            grade,
          );
    } else {
      await ref.read(studentsProvider.notifier).addStudent(
            firstNameController.text.trim(),
            lastNameController.text.trim(),
            selectedDepartment,
            selectedGender,
            grade,
          );
    }

    if (!context.mounted) return;

    Navigator.of(context).pop(null);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(studentsProvider.notifier);
    Widget newStudentScreen = Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Додати/Редагувати студента',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  labelText: 'Ім’я',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Прізвище',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Department>(
                value: selectedDepartment,
                decoration: const InputDecoration(
                  labelText: 'Факультет',
                  border: OutlineInputBorder(),
                ),
                items: departments.map((department) {
                  return DropdownMenuItem(
                    value: department,
                    child: Row(
                      children: [
                        Icon(department.icon, size: 20),
                        const SizedBox(width: 8),
                        Text(department.name),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDepartment = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Gender>(
                value: selectedGender,
                decoration: const InputDecoration(
                  labelText: 'Стать',
                  border: OutlineInputBorder(),
                ),
                items: Gender.values.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(
                      gender.toString().split('.').last.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              Slider(
                value: grade.toDouble(),
                min: 0,
                max: 100,
                divisions: 100,
                label: 'Оцінка: $grade',
                activeColor: Colors.teal,
                onChanged: (value) {
                  setState(() {
                    grade = value.toInt();
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.cancel, color: Colors.black),
                    label: const Text(
                      'Відмінити',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: saveStudent,
                    icon: const Icon(Icons.save, color: Colors.black),
                    label: const Text(
                      'Зберегти',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade400,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    if(notifier.isLoading) {
      newStudentScreen = const Center(
        child: CircularProgressIndicator(),
      );
    }
    return newStudentScreen;
  }
}
