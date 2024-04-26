import 'package:deliveryz_front/database/kitchen/kitchen_queries.dart';
import 'package:deliveryz_front/pages/home/home_cooker.dart';
import 'package:flutter/material.dart';
import 'package:deliveryz_front/database/order/order_queries.dart';


class OrderItemWidget extends StatelessWidget {
  final String price;
  final String product;
  final bool isEnabled;
  final String status;
  final String orderId;

  const OrderItemWidget({
    required this.orderId,
    required this.price,
    required this.product,
    required this.isEnabled,
    required this.status,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Product: $product",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Theme.of(context).colorScheme.background,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Price: $price",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Theme.of(context).colorScheme.background,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          if (status == "pending")
            Row(
              children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.background,
                  ),
                ),
                onPressed: isEnabled ? () {
                  OrderService().cancelOrder(orderId).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor:
                        Theme.of(context).colorScheme.secondary,
                        content: Text('Item canceled',
                            style: TextStyle(
                              color:
                              Theme.of(context).colorScheme.onPrimary,
                            )),
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => const HomeCookerPage()),
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
                } : null,
                child: Text('Cancel',
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onBackground)
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.error,
                  ),
                ),
                onPressed: isEnabled ? () {
                  validateOrder(orderId).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor:
                        Theme.of(context).colorScheme.secondary,
                        content: Text('Item validated',
                            style: TextStyle(
                              color:
                              Theme.of(context).colorScheme.onPrimary,
                            )),
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => const HomeCookerPage()),
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
                } : null,
                child: Text('Validate',
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onPrimary)
                  ),
                ),
              ]
            )
          else
            Expanded(
              child: Text(
                "Status: $status",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
