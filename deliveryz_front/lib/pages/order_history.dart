import 'package:flutter/material.dart';
import 'package:deliveryz_front/models/order.dart';
import 'package:deliveryz_front/utils/shared_prefs_manager.dart';
import 'package:deliveryz_front/database/order/order_queries.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Future<List<Order>> futureOrders;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    String userId = (await SharedPrefsManager.getId())!;
    futureOrders = OrderService().getOrdersById(userId);
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des commandes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => {},
          ),
        ],
      ),
      body: FutureBuilder<List<Order>>(
        future: futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Order order = snapshot.data![index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    order.productName ?? 'No product name',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ${order.quantity} - \$${order.totalPrice}'),
                      Text('Client ID: ${order.clientId}'),
                      Text('Cooker ID: ${order.cookerId}'),
                      if (order.status != null) Text('Status: ${order.status}'),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
