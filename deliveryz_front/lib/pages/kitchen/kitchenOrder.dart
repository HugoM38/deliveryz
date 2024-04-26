import 'package:flutter/material.dart';
import 'order_item.dart';

import '../../database/kitchen/kitchen_queries.dart';

class KitchenOrderPage extends StatelessWidget {
  const KitchenOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    var data = getMenu("cookerId");
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login Page',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              OrderItemWidget(
                leftText: 'Email:',
                onPressed: () {}, // Placeholder onPressed function
                isEnabled: true,
              ),
              OrderItemWidget(
                leftText: 'Password:',
                onPressed: () {}, // Placeholder onPressed function
                isEnabled: true,
              ),
              OrderItemWidget(
                leftText: 'Selected Role:',
                onPressed: () {}, // Placeholder onPressed function
                isEnabled: false,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}