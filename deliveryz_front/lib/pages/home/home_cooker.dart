import 'package:flutter/material.dart';

class HomeCookerPage extends StatefulWidget {
  const HomeCookerPage({super.key});

  @override
  State<HomeCookerPage> createState() => _HomeCookerPageState();
}

class _HomeCookerPageState extends State<HomeCookerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home Cooker Page',
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