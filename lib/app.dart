import 'package:flutter/material.dart';
import 'package:uwuployyy/features/auth/screens/login_screen.dart';
import 'package:uwuployyy/features/auth/screens/register_screen.dart';
import 'package:uwuployyy/features/auth/screens/welcome_screen.dart';
import 'package:uwuployyy/features/auth/screens/profile_screen.dart';
import 'package:uwuployyy/features/auth/screens/id_list_screen.dart';
import 'package:uwuployyy/features/admin/screens/add_id_screen.dart'; // Korrekter Import
import 'package:uwuployyy/features/auth/screens/user_list_screen.dart';
import 'package:uwuployyy/features/admin/screens/edit_user_screen.dart';
import 'package:uwuployyy/core/models/admin_user_model.dart';

class UwUPloyApp extends StatelessWidget {
  const UwUPloyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UwUPloy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/idList': (context) => const IdListScreen(),
        '/addId': (context) => const AddIdScreen(), // Korrekter Import
        '/userList': (context) => const UserListScreen(),
        '/editUser': (context) =>
            EditUserScreen(user: AdminUserModel(id: '', email: '', userId: '')),
      },
    );
  }
}