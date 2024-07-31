import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final String description;
  final DateTime deadline;
  final TaskUrgency urgency; // Добавляем поле для срочности

  const TaskItem({
    Key? key,
    required this.title,
    required this.description,
    required this.deadline,
    required this.urgency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( // Обертка для всей задачи с градиентом
      margin: const EdgeInsets.only(bottom: 16), // Отступ между задачами
      decoration: BoxDecoration(
        gradient: getGradientForUrgency(urgency), // Получаем градиент
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 0), // Уменьшаем отступ сверху
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Белый текст для контраста
            ),
          ),
          const SizedBox(height: 4), // Уменьшаем отступ после заголовка
          Text(
            description,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row( // Добавляем Row для кнопок
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Располагаем кнопки по краям
            children: [
              Text(
                'Дедлайн: ${deadline.day.toString().padLeft(2, '0')}.${deadline.month.toString().padLeft(2, '0')}.${deadline.year} ${deadline.hour.toString().padLeft(2, '0')}:${deadline.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 14),
              ),
              Row( // Добавляем Row для кнопок
                children: [
                  IconButton(
                    onPressed: () {
                      // Обработка нажатия на кнопку "Редактировать"
                      print('Редактировать задачу');
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      // Обработка нажатия на кнопку "Удалить"
                      print('Удалить задачу');
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Функция для получения градиента в зависимости от срочности
  LinearGradient getGradientForUrgency(TaskUrgency urgency) {
    switch (urgency) {
      case TaskUrgency.high:
        return LinearGradient(
          colors: [Colors.red, Colors.white], // Добавляем красный цвет в конце
          begin: Alignment.topCenter, // Начало градиента в верхнем центре
          end: Alignment.bottomCenter, // Конец градиента в нижнем центре
        );
      case TaskUrgency.medium:
        return LinearGradient(
          colors: [Colors.orange, Colors.white], // Добавляем оранжевый цвет в конце
          begin: Alignment.topCenter, // Начало градиента в верхнем центре
          end: Alignment.bottomCenter, // Конец градиента в нижнем центре
        );
      case TaskUrgency.low:
        return LinearGradient(
          colors: [Colors.green, Colors.white], // Добавляем зеленый цвет в конце
          begin: Alignment.topCenter, // Начало градиента в верхнем центре
          end: Alignment.bottomCenter, // Конец градиента в нижнем центре
        );
    }
  }
}

// Перечисление для срочности задач
enum TaskUrgency { high, medium, low }
