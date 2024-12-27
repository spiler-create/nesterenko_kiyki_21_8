import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/students_provider.dart';
import '../widgets/student_item.dart';
import '../widgets/new_student.dart';

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsProvider);
    final notifier = ref.watch(studentsProvider.notifier);

    return Scaffold(
      
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          if(notifier.isLoading) 
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (students == null)
            const Center(
              child: Text(
                'Список порожній',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),
            )
          else
            ListView.builder(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 100, 
              ),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Dismissible(
                  key: ValueKey(student.id),
                  background: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    ref.read(studentsProvider.notifier).removeStudent(index);
                    final temp = ProviderScope.containerOf(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${student.firstName} ${student.lastName} видалено',
                        ),
                        action: SnackBarAction(
                          label: 'Відмінити',
                          onPressed: () {
                            temp.read(studentsProvider.notifier).undoStudent();
                          },
                        ),
                      ),
                    ).closed.then((value) {
                        if (value != SnackBarClosedReason.action) {
                          ref.read(studentsProvider.notifier).permanentlyRemove();
                        }
                      });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: StudentItem(
                      student: student,
                      onEdit: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => NewStudent(
                            studentIndex: index
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => NewStudent());
                },
                icon: const Icon(
                  Icons.add,
                  size: 28,
                  color: Colors.white,
                ),
                label: const Text(
                  'Додати студента',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  backgroundColor: Colors.indigoAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.blueAccent,
                  elevation: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
