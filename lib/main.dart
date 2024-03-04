import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_api_app/module/provider/news_provider.dart';
import 'package:quotes_api_app/module/view/favourite_page.dart';
import 'package:quotes_api_app/module/view/home/home_screen.dart';
import 'package:quotes_api_app/module/view/home/splash_screen.dart';

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
          'favourite_page': (context) => FavoriteScreen(),
          'splash_screen': (context) => const splash_screen(),
        },
      ),
    );
  }
}
