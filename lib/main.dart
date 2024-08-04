import 'package:flutter/material.dart';
import 'package:money_manager_clone/ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Manager',
      home: Container(
        child: HomePage()
      ),
    );
  }
}
