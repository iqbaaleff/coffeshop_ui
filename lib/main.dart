import 'package:coffeshop_ui/navigations/bottom_nav.dart';
import 'package:coffeshop_ui/providers/cart_provider.dart';
import 'package:coffeshop_ui/providers/order_history_provider.dart';
import 'package:coffeshop_ui/screens/intro_page.dart';
import 'package:coffeshop_ui/screens/login_page.dart';
import 'package:coffeshop_ui/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => OrderHistoryProvider()),
    ],
    child: const MyApp(),
  ),
);

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
        '/home': (context) => const BottomNav(),
      },
    );
  }
}
