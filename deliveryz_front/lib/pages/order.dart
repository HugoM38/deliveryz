import 'package:flutter/material.dart';
import 'package:deliveryz_front/models/order.dart';
import 'package:deliveryz_front/database/order_queries.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Future<List<Order>> futureOrders;
  final productNameController = TextEditingController();
  final quantityController = TextEditingController();
  final totalPriceController = TextEditingController();


  @override
  void initState() {
    super.initState();
    futureOrders = OrderService().fetchOrders();
  }

  @override
  void dispose() {
    productNameController.dispose();
    quantityController.dispose();
    totalPriceController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddOrderDialog(),
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

          if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }

          final orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return ListTile(
                title: Text(
                    '${order.productName ?? "No product name"} x${order.quantity}'),
                subtitle: Text(
                    'Status: ${order.status ?? "No status"} - \$${order.totalPrice ?? "No price"}'),
                isThreeLine: true,
                trailing: Text('Contact: ${order.contactPhone ?? "No phone"}'),
              );
            },
          );
        },
      ),
      backgroundColor: Colors.grey,
    );
  }
  void _showAddOrderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add New Order"),
          content: _buildDialogForm(context),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Submit"),
              onPressed: () {
                // Call function to submit the data
                _submitOrder();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogForm(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: productNameController,
            decoration: InputDecoration(labelText: 'Product Name'),
          ),
          TextFormField(
            controller: quantityController,
            decoration: InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: totalPriceController,
            decoration: InputDecoration(labelText: 'Total Price'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  void _submitOrder() {
    final orderData = {
      'productName': productNameController.text,
      'quantity': int.parse(quantityController.text),
      'totalPrice': double.parse(totalPriceController.text),
      'clientId': 'client123',  // Example static data
      'cookerId': 'cook456',  // Example static data
      'status': 'pending',  // Default status
    };

    OrderService().createOrder(orderData).then((Order order) {
      Navigator.of(context).pop();  // Close the dialog
      setState(() {
        futureOrders = OrderService().fetchOrders();  // Refresh the list
      });
    }).catchError((error) {
      print('Error creating order: $error');
    });
  }
}