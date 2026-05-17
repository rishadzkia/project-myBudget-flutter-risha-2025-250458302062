import 'package:flutter/material.dart';
import 'package:my_budget/auth/pages/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyBudget',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF001E3A),
          background: Color(0xFF094174),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
