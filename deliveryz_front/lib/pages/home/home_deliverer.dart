import 'package:flutter/material.dart';

class HomeDelivererPage extends StatefulWidget {
  const HomeDelivererPage({super.key});

  @override
  State<HomeDelivererPage> createState() => __HomeDelivererPageState();
}

class __HomeDelivererPageState extends State<HomeDelivererPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home Deliverer Page',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}