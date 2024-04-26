import 'dart:convert';
import 'package:http/http.dart' as http;
import '/models/order.dart';

class OrderService {
  final String baseUrl = 'http://localhost:3000/orders/';
  final String accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Imh1Z3plciIsImlkIjoiZjdIdktrbjd6S29OaVRrcklQdU0iLCJpYXQiOjE3MTQwNjU3NTUsImV4cCI6MTcxNDA2NzU1NX0.uLaOMUiawSc7gEp-BmR9N9uRGqMDBwShaD_bCaqWkgA';

  Future<List<Order>> fetchOrders() async {
    print('Starting to fetch orders...');
    try {
      final uri = Uri.parse(baseUrl);
      print('Making HTTP GET request to: $uri');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
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
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(orderData),
    );

    if (response.statusCode == 201) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create order: ${response.body}');
    }
  }
}
