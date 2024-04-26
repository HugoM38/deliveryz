import 'dart:convert';
import 'package:http/http.dart' as http;
import '/models/order.dart';
import 'package:deliveryz_front/utils/shared_prefs_manager.dart';

class OrderService {
  final String baseUrl = 'http://localhost:3000/orders/';

  Future<List<Order>> fetchOrders() async {
    print('Starting to fetch orders...');
    try {
      final uri = Uri.parse(baseUrl);
      print('Making HTTP GET request to: $uri');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await SharedPrefsManager.getToken()}',
        },
      );
      print('HTTP status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        List<dynamic> body = jsonDecode(response.body);
        List<Order> orders =
            body.map((dynamic item) => Order.fromJson(item)).toList();
        print('Parsed orders: $orders');
        return orders;
      } else {
        print(
            'Failed to load orders, server responded with ${response.statusCode}: ${response.body}');
        throw Exception('Failed to load orders: ${response.body}');
      }
    } catch (e) {
      print('Exception caught fetching orders: $e');
      throw Exception('Failed to load orders: $e');
    }
  }

  Future<void> cancelOrder(orderId) async {
    final uri =  Uri.parse("$baseUrl/cancel/$orderId");
    final response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ await SharedPrefsManager.getToken()}',
      },
      body: jsonEncode({
        'itemId': "canceled",
      }),
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to create order: ${response.body}');
    }
  }

  Future<List<Order>> getOrdersById(String userId) async {
    // Log to see which user ID is being used
    print("Fetching orders for User ID: $userId");

    String role = (await SharedPrefsManager.getRole())!;
    print("User Role: $role"); // Log to check the role

    Uri url;

    switch (role) {
      case 'Client':
        url = Uri.parse("${baseUrl}clients/$userId");
        print("Using Client URL: $url"); // Log the URL being used
        break;
      case 'Restaurant':
        url = Uri.parse("${baseUrl}cookers/$userId");
        print("Using Restaurant URL: $url");
        break;
      case 'Livreur':
        url = Uri.parse("${baseUrl}deliverers/$userId");
        print("Using Livreur URL: $url");
        break;
      default:
        url = Uri.parse("${baseUrl}clients/$userId");
        print("Defaulting to Client URL: $url");
    }

    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await SharedPrefsManager.getToken()}',
        },
      );

      print(
          "HTTP Status Code: ${response.statusCode}"); // Log the status code of the response

      if (response.statusCode != 200) {
        print(
            "Failed to load orders with body: ${response.body}"); // Detailed error log
        throw Exception('Failed to load orders: ${response.body}');
      }

      List<Order> orders = (jsonDecode(response.body) as List)
          .map((orderJson) => Order.fromJson(orderJson))
          .toList();

      print(
          "Orders fetched successfully: ${orders.length} orders found"); // Log the count of orders fetched

      return orders;
    } catch (e) {
      print(
          "Error fetching orders: ${e.toString()}"); // Log any exceptions thrown
      throw Exception('Failed to fetch orders: ${e.toString()}');
    }
  }
}
