import 'package:flutter/material.dart';
import 'package:deliveryz_front/database/kitchen/kitchen_queries.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Future<List<dynamic>> futureOrders;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('id') ?? '';
    String role = prefs.getString('role') ?? '';

    if (role == 'Restaurant') {
      futureOrders = getOrdersByCooker(userId);
      setState(() {});
    } else {
      print('Not authorized or no role found');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders for Cooker'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => {},
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
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
              var order = snapshot.data![index];
              return ListTile(
                title: Text(
                  order['productName'] ?? 'No product name',
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Quantity: ${order['quantity']} - \$${order['totalPrice']}',
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
