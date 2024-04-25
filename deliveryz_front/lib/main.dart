import 'package:deliveryz_front/pages/auth/login.dart';
import 'package:flutter/material.dart';

import 'pages/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliveryZ',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
      theme: ThemeData(
              colorScheme: const ColorScheme(
                brightness: Brightness.dark,
                primary: Color(0xFF3F334D),
                onPrimary: Color(0xffEAF0CE),
                secondary: Color(0xff574B60),
                onSecondary: Color(0xffEAF0CE),
                tertiary: Color(0xff7D8491),
                onTertiary: Color(0xffEAF0CE),
                error: Colors.red,
                onError: Colors.white,
                background: Color(0xffEAF0CE),
                onBackground: Color(0xff3F334D),
                surface: Color(0xff574B60),
                onSurface: Color(0xffEAF0CE),
              ),
            ),
      home: const LoginPage(),
    );
  }
}
