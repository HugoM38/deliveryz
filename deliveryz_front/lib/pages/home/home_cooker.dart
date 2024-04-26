import 'package:deliveryz_front/database/kitchen/kitchen_queries.dart';
import 'package:deliveryz_front/pages/kitchen/kitchen_menu.dart';
import 'package:deliveryz_front/utils/shared_prefs_manager.dart';
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
      appBar: AppBar(
        title: const Text('DeliveryZ'),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.background),
            ),
            onPressed: () async {
              String id = (await SharedPrefsManager.getId())!;
              getCookers().then((cookers) {
                for (var cooker in cookers!) {
                  if (cooker.id == id) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => KitchenMenuPage(cooker: cooker),
                      ),
                    );
                  }
                }
              }).catchError((e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    content: Text(e,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onError,
                        )),
                  ),
                );
              });
            },
            child: const Text('Voir mon menu'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.error),
            ),
            onPressed: () async {
              await SharedPrefsManager.logoutUser();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              }
            },
            child: const Text('Déconnexion'),
          )
        ],
      ),
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
