import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_manager_clone/ui/home_page.dart';
import 'package:money_manager_clone/ui/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Themes.primaryColor
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Manager',
      theme: Themes().lightTheme,
      home: Container(
        child: const HomePage(initialIndex: 0,)
      ),
    );
  }
}
