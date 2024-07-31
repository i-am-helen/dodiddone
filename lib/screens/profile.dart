import 'package:dodiddone/pages/login_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( // Обертка для содержимого страницы профиля
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/avatar.jpg'), // Замените на ваш аватар
          ),
          const SizedBox(height: 20),
          Text(
            'user@example.com', // Замените на почту пользователя
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Обработка нажатия на кнопку подтверждения почты
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Подтверждение почты'),
                  content: const Text('Письмо с подтверждением отправлено на ваш адрес.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 15,
              ),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Подтвердить почту',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Обработка нажатия на кнопку выхода
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return const LoginPage();
              }));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 15,
              ),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Выйти',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
