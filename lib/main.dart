import 'package:coffeshop_ui/screens/home_page.dart';
import 'package:coffeshop_ui/screens/intro_page.dart';
import 'package:coffeshop_ui/screens/login_page.dart';
import 'package:coffeshop_ui/screens/register_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Baltivers Coffe",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'PlayfairDisplay', useMaterial3: true),
      initialRoute: '/intro',
      routes: {
        '/intro': (context) => const IntroPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
