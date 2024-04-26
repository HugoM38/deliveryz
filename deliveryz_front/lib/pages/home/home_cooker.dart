import 'package:flutter/material.dart';
import 'package:deliveryz_front/pages/order_history.dart'; // Assurez-vous d'importer correctement votre OrdersPage

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Home Cooker Page',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OrdersPage(),
                  ),
                );
              },
              child: Text('View Order History'),
            ),
          ],
        ),
      ),
    );
  }
}