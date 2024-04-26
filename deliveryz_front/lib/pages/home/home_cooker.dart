import 'package:deliveryz_front/database/kitchen/kitchen_queries.dart';
import 'package:deliveryz_front/pages/kitchen/kitchen_menu.dart';
import 'package:deliveryz_front/utils/shared_prefs_manager.dart';
import 'package:flutter/material.dart';
import '../kitchen/order_item.dart'; // Assurez-vous d'importer correctement votre OrdersPage

class HomeCookerPage extends StatefulWidget {
  const HomeCookerPage({super.key});

  @override
  State<HomeCookerPage> createState() => _HomeCookerPageState();
}

class _HomeCookerPageState extends State<HomeCookerPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
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
                      Expanded( // Ajoutez Expanded autour de la Row pour distribuer l'espace disponible
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    for (int index = 0; index < orders.length; index++)
                                      if (orders[index]["status"] == "pending")
                                        OrderItemWidget(
                                          orderId: '${orders[index]["id"]}',
                                          product: '${orders[index]["productName"]}',
                                          price: '${orders[index]["totalPrice"]}',
                                          status: '${orders[index]["status"]}',
                                          isEnabled: true,
                                        ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    for (int index = 0; index < orders.length; index++)
                                      if (orders[index]["status"] != "pending")
                                        OrderItemWidget(
                                          orderId: '${orders[index]["id"]}',
                                          product: '${orders[index]["productName"]}',
                                          price: '${orders[index]["totalPrice"]}',
                                          status: '${orders[index]["status"]}',
                                          isEnabled: true,
                                        ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        }
    );
  }
}
String id = '';
var orders;

Future<void> getData() async {
  id = (await SharedPrefsManager.getId())!;
  orders = await getOrdersByCooker(id);

}
