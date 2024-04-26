import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../utils/shared_prefs_manager.dart';
import '/models/order.dart';

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
          'Authorization': 'Bearer ${ await SharedPrefsManager.getToken()}',
        },
      );
      print('HTTP status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        List<dynamic> body = jsonDecode(response.body);
        List<Order> orders = body.map((dynamic item) => Order.fromJson(item)).toList();
        print('Parsed orders: $orders');
        return orders;
      } else {
        print('Failed to load orders, server responded with ${response.statusCode}: ${response.body}');
        throw Exception('Failed to load orders: ${response.body}');
      }
    } catch (e) {
      print('Exception caught fetching orders: $e');
      throw Exception('Failed to load orders: $e');
    }
  }

  Future<Order> createOrder(Map<String, dynamic> orderData) async {
    final uri = Uri.parse(baseUrl);
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ await SharedPrefsManager.getToken()}',
      },
      body: jsonEncode(orderData),
    );

    if (response.statusCode == 201) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create order: ${response.body}');
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
}
