import 'package:deliveryz_front/pages/auth/login.dart';
import 'package:deliveryz_front/pages/auth/signup.dart';
import 'package:deliveryz_front/pages/home/home_cooker.dart';
import 'package:deliveryz_front/pages/home/home_deliverer.dart';
import 'package:deliveryz_front/utils/auth_observer.dart';
import 'package:flutter/material.dart';

import 'pages/home/home_client.dart';
import 'pages/order_history.dart';

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
      navigatorObservers: [AuthObserver()],
      routes: <String, WidgetBuilder>{
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home-client': (context) => const HomeClientPage(),
        '/home-cooker': (context) => const HomeCookerPage(),
        '/home-deliverer': (context) => const HomeDelivererPage(),
        '/order': (context) => const OrdersPage(),
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
      initialRoute: '/login',
    );
  }
}
