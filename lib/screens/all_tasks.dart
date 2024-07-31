import 'package:flutter/material.dart';
import 'package:dodiddone/widgets/task_item.dart'; // Импортируем TaskItem

class TasksPage extends StatelessWidget {
  TasksPage({Key? key}) : super(key: key); // Remove 'const'

  // Sample task data (replace with actual data)
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Задача 1',
      'description': 'Описание задачи 1',
      'deadline': DateTime.now().add(Duration(days: 7)),
      'urgency': TaskUrgency.low,
    },
    {
      'title': 'Задача 2',
      'description': 'Описание задачи 2',
      'deadline': DateTime.now().add(Duration(days: 5)),
      'urgency': TaskUrgency.low,
    },
    {
      'title': 'Задача 3',
      'description': 'Описание задачи 3',
      'deadline': DateTime.now().add(Duration(days: 3)),
      'urgency': TaskUrgency.medium,
    },
    {
      'title': 'Задача 4',
      'description': 'Описание задачи 4',
      'deadline': DateTime.now().add(Duration(days: 2)),
      'urgency': TaskUrgency.medium,
    },
    {
      'title': 'Задача 5',
      'description': 'Описание задачи 5',
      'deadline': DateTime.now().add(Duration(days: 1)),
      'urgency': TaskUrgency.high,
    },
    {
      'title': 'Задача 6',
      'description': 'Описание задачи 6',
      'deadline': DateTime.now().add(Duration(hours: 12)),
      'urgency': TaskUrgency.high,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40), // Добавляем отступ сверху
          const Text(
            'Задачи',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14), // Убираем отступ после заголовка
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero, // Убираем отступ у ListView
              itemCount: tasks.length, // Use actual task count
              itemBuilder: (context, index) {
                return TaskItem(
                  title: tasks[index]['title'],
                  description: tasks[index]['description'],
                  deadline: tasks[index]['deadline'],
                  urgency: tasks[index]['urgency'], // Get urgency from data
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
