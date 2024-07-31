import 'package:dodiddone/screens/all_tasks.dart';
import 'package:dodiddone/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:dodiddone/theme/theme.dart'; // Импортируем тему
import 'package:dodiddone/screens/profile.dart'; // Импортируем ProfilePage
import 'package:intl/intl.dart'; // Импортируем Intl для форматирования даты

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    TasksPage(),
    Text('Сегодня'),
    ProfilePage(),
    Text('Выполнено'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Функция для открытия диалогового окна
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Контроллеры для ввода данных
        final titleController = TextEditingController();
        final descriptionController = TextEditingController();
        final deadlineController = TextEditingController();
        DateTime? selectedDate; // Переменная для выбранной даты

        return AlertDialog(
          title: const Text('Добавить задачу'),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Уменьшаем размер диалога
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Название',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Описание',
                ),
              ),
              const SizedBox(height: 16),
              // Поле для выбора даты и времени
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: deadlineController,
                      decoration: const InputDecoration(
                        labelText: 'Дедлайн',
                      ),
                      readOnly: true, // Делаем поле только для чтения
                      onTap: () async {
                        // Открываем календарь для выбора даты
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          // Выбираем время
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (pickedTime != null) {
                            // Собираем дату и время
                            selectedDate = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );

                            // Форматируем дату и время для отображения
                            deadlineController.text = DateFormat(
                                    'dd.MM.yyyy HH:mm').format(selectedDate!);
                          }
                        }
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      // Открываем календарь для выбора даты
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        // Выбираем время
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          // Собираем дату и время
                          selectedDate = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );

                          // Форматируем дату и время для отображения
                          deadlineController.text = DateFormat(
                                  'dd.MM.yyyy HH:mm').format(selectedDate!);
                        }
                      }
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                // Обработка добавления новой задачи
                print('Добавить задачу: ${titleController.text}');
                print('Описание: ${descriptionController.text}');
                print('Дедлайн: ${deadlineController.text}');
                // Вычисляем срочность на основе дедлайна
                TaskUrgency urgency = _calculateUrgency(selectedDate!);
                print('Срочность: $urgency');
                Navigator.pop(context);
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );
  }

  // Функция для вычисления срочности на основе дедлайна
  TaskUrgency _calculateUrgency(DateTime deadline) {
    Duration difference = deadline.difference(DateTime.now());
    if (difference.inDays <= 1) {
      return TaskUrgency.high;
    } else if (difference.inDays <= 3) {
      return TaskUrgency.medium;
    } else {
      return TaskUrgency.low;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Прозрачный AppBar
        elevation: 0, // Убираем тень
      ),
      body: Container( // Добавляем Container для градиента
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              DoDidDoneTheme.lightTheme.colorScheme.secondary, // Вторичный цвет
              DoDidDoneTheme.lightTheme.colorScheme.primary, // Основной цвет
            ],
          ),
        ),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent, // Прозрачный BottomNavigationBar
        elevation: 0, // Убираем тень
        type: BottomNavigationBarType.fixed, // Устанавливаем тип BottomNavigationBar
        selectedItemColor: Theme.of(context).colorScheme.primary, // Основной цвет для выбранного элемента
        unselectedItemColor: Colors.grey, // Серый цвет для невыбранных элементов
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Задачи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Сегодня',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Выполнено',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog, // Вызываем функцию для открытия диалога
        child: const Icon(Icons.add),
      ),
    );
  }
}
