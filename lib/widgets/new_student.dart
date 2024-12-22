import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/student.dart';

class NewStudent extends StatefulWidget {
  final Student? student;
  final Function(Student) onSave;

  const NewStudent({super.key, this.student, required this.onSave});

  @override
  State<NewStudent> createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  Department? _selectedDepartment;
  Gender? _selectedGender;
  int _grade = 50;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _firstNameController.text = widget.student!.firstName;
      _lastNameController.text = widget.student!.lastName;
      _selectedDepartment = widget.student!.department;
      _selectedGender = widget.student!.gender;
      _grade = widget.student!.grade;
    }
  }

  void _saveStudent() {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _selectedDepartment == null ||
        _selectedGender == null) {
      return;
    }

    final newStudent = Student(
      id: widget.student?.id ?? const Uuid().v4(),
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      department: _selectedDepartment!,
      grade: _grade,
      gender: _selectedGender!,
    );

    widget.onSave(newStudent);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Додати/Редагувати студента',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'Ім’я',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Прізвище',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<Department>(
                  value: _selectedDepartment,
                  decoration: const InputDecoration(
                    labelText: 'Факультет',
                    border: OutlineInputBorder(),
                  ),
                  items: Department.values.map((department) {
                    return DropdownMenuItem(
                      value: department,
                      child: Row(
                        children: [
                          Icon(departmentIcons[department]!),
                          const SizedBox(width: 8),
                          Text(department.name),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedDepartment = value),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<Gender>(
                  value: _selectedGender,
                  decoration: const InputDecoration(
                    labelText: 'Стать',
                    border: OutlineInputBorder(),
                  ),
                  items: Gender.values.map((gender) {
                    return DropdownMenuItem(
                      value: gender,
                      child: Text(gender.name),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedGender = value),
                ),
                const SizedBox(height: 16),
                Slider(
                  value: _grade.toDouble(),
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: 'Оцінка: $_grade',
                  onChanged: (value) => setState(() => _grade = value.toInt()),
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
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        backgroundColor: Colors.red.shade400,
                        shadowColor: Colors.red.shade200,
                        elevation: 5,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _saveStudent,
                      icon: const Icon(Icons.check_circle, color: Colors.black),
                      label: Text(
                        widget.student == null ? 'Додати' : 'Оновити',
                        style: const TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        backgroundColor: Colors.green.shade500,
                        shadowColor: Colors.green.shade300,
                        elevation: 5,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
