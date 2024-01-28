import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_api_app/provider/news_provider.dart';
import 'package:quotes_api_app/view/favourite_page.dart';
import 'package:quotes_api_app/view/home/home_screen.dart';
import 'package:quotes_api_app/view/home/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => newsprovider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash_screen',
        routes: {
          '/': (context) => const Home_Page(),
          // 'detal_page': (context) => const detal_page(),
          'favourite_page': (context) => const favourite_page(),
          'splash_screen': (context) => const splash_screen(),
        },
      ),
    );
  }
}
