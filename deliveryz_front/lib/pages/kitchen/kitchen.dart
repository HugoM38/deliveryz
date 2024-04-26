import 'package:flutter/material.dart';
import 'menu_item.dart';

import '../../database/kitchen/kitchen_queries.dart';

class KitchenPage extends StatelessWidget {
  const KitchenPage({Key? key}) : super(key: key);

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
              MenuItemWidget(
                leftText: 'Email:',
                rightText: 'Enter your email',
                onPressed: () {}, // Placeholder onPressed function
              ),
              MenuItemWidget(
                leftText: 'Password:',
                rightText: 'Enter your password',
                onPressed: () {}, // Placeholder onPressed function
              ),
              MenuItemWidget(
                leftText: 'Selected Role:',
                rightText: 'Client',
                onPressed: () {}, // Placeholder onPressed function
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Additional Information',
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}