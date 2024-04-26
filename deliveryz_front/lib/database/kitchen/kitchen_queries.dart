import 'dart:convert';

import 'package:deliveryz_front/utils/shared_prefs_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

var baseUrl = 'http://localhost:3000/kitchens/';

Future<String> getMenu(String cookerId) async {
  Uri url = Uri.parse("${baseUrl}menu/$cookerId");
  try {
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ await SharedPrefsManager.getToken()}'
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    return response.body;
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<void> addMenu(String cookerId, String item, double? price) async {
  Uri url = Uri.parse("${baseUrl}menu/$cookerId");
  try {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ await SharedPrefsManager.getToken()}'
      },
      body: jsonEncode({
        'name': item,
        'price': price
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    if (response.body.isNotEmpty) {
      return jsonDecode(response.body);
    } else {
      return;
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<void> removeMenu(String cookerId, int id) async {
  Uri url = Uri.parse("${baseUrl}menu/$cookerId");

  try {
    var response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ await SharedPrefsManager.getToken()}'
      },
      body: jsonEncode({
        'itemId': id,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    if (response.body.isNotEmpty) {
      return jsonDecode(response.body);
    } else {
      return;
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<List<List<String>>?> getCookers() async {
  return null;
}

Future<List<List<String>>?> getOrders() async {
  return null;
}

Future<void> orderReady() async {
  return;
}

Future<List<dynamic>> getOrdersByCooker(String cookerId) async {
  Uri url = Uri.parse("${baseUrl}orders/$cookerId");
  try {
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Imh1Z28iLCJpZCI6ImJHaVBJTERITVlTaGdKcklqSGx2IiwiaWF0IjoxNzE0MTI0NDMzLCJleHAiOjE3MTQxMjYyMzN9.ri551T1jxrsPwtOlVA3zruMqxdLYCk3GaAH4GbTqS6Q',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load orders: ${response.body}');
    }

    return jsonDecode(response.body); 
  } catch (e) {
    throw Exception('Failed to fetch orders: ${e.toString()}');
  }
}
