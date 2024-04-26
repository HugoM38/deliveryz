import 'dart:convert';

import 'package:deliveryz_front/utils/shared_prefs_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'menu_item.dart';

import '../../database/kitchen/kitchen_queries.dart';

class KitchenPage extends StatelessWidget {
  const KitchenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Affichez un indicateur de chargement pendant que les données sont chargées
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Si les données sont chargées avec succès, affichez la page principale
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int index = 0; index < jsonList.length; index++)
                      MenuItemWidget(
                      leftText: jsonList[index]['name'],
                        rightText: '\$${jsonList[index]['price']}',
                        onPressed: () {
                          removeMenu(id, index).then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                                content: Text('Item removed',
                                    style: TextStyle(
                                      color:
                                      Theme.of(context).colorScheme.onPrimary,
                                    )),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) => KitchenPage()),
                            );
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor:
                                Theme.of(context).colorScheme.error,
                                content: Text(
                                  error.toString(),
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.onError),
                                ),
                              ),
                            );
                          });
                        },
                      ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (text) {
                              item = text;
                            },
                            decoration: InputDecoration(
                              labelText: 'Item name',
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (text) {
                              if(text.isEmpty){
                                price = null;
                              } else {
                                price = double.parse(text);
                              }
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d*)?$')),
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Price',
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: (){
                            addMenu(id, item, price).then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                                  content: Text('Item added',
                                      style: TextStyle(
                                        color:
                                        Theme.of(context).colorScheme.onPrimary,
                                      )),
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (BuildContext context) => KitchenPage()),
                              );
                            }).catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor:
                                  Theme.of(context).colorScheme.error,
                                  content: Text(
                                    error.toString(),
                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.onError),
                                  ),
                                ),
                              );
                            });
                          },
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
      },
    );
  }
}

String item = '';
double? price = null;
String id = '';
String menu = '';
var jsonList;

Future<void> getData() async {
  id = (await SharedPrefsManager.getId())!;
  menu = await getMenu(id);
  jsonList = jsonDecode(menu);
}
