import 'package:flutter/material.dart';
import 'package:quotes_api_app/view/detail_page.dart';
import 'package:quotes_api_app/view/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'welcome',
      routes: {
        '/': (context) => const HomePage(),
        'detal_page': (context) => detal_page(),
      },
    );
  }
}
