// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:women_safety/screens/onboarding/welcome_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Here I Am',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: WelcomeScreen(),
    );
  }
}
