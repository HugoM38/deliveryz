import 'package:deliveryz_front/database/order/order_queries.dart';
import 'package:deliveryz_front/models/order.dart';
import 'package:deliveryz_front/models/user.dart';
import 'package:deliveryz_front/utils/shared_prefs_manager.dart';
import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final String name;
  final double price;
  final VoidCallback onPressed;
  final bool isCookerOwner;
  final Cooker cooker;

  const MenuItemWidget({
    super.key,
    required this.isCookerOwner,
    required this.name,
    required this.price,
    required this.onPressed,
    required this.cooker,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  price.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                const SizedBox(width: 16),
                Visibility(
                  visible: isCookerOwner,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: Text('Delete',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        )),
                  ),
                ),
                Visibility(
                  visible: !isCookerOwner,
                  child: ElevatedButton(
                    onPressed: () async {
                      OrderService()
                          .createOrder(Order(
                            quantity: 1,
                            cookerId: cooker.id!,
                            clientId: (await SharedPrefsManager.getId())!,
                            productName: name,
                            totalPrice: price,
                            status: 'pending'
                          ).toJson())
                          .then((order) => {
                            print(order),
                            Navigator.pop(context)})
                          .catchError((e) => {

                              print(e),
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.error,
                                    content: Text(
                                      e,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                  ),
                                )
                              });
                    },
                    child: Text(
                      'Commander',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
