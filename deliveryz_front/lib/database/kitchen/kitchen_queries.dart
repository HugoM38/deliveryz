import 'dart:async';
import 'dart:convert';
import 'package:deliveryz_front/utils/shared_prefs_manager.dart';
import 'package:deliveryz_front/models/user.dart';
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

Future<List<Cooker>?> getCookers() async {
  Uri url = Uri.parse(baseUrl);
  try {
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await SharedPrefsManager.getToken()}',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    List<Cooker> cookers = [];

    for (var cooker in jsonDecode(response.body)) {
      cookers.add(Cooker.fromJson(cooker));
    }
    return cookers;
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<List<List<String>>?> getOrders() async {
  return null;
}

Future<List<dynamic>> getOrdersByCooker(String cookerId) async {
  Uri url = Uri.parse("${baseUrl}orders/$cookerId");
  try {
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ await SharedPrefsManager.getToken()}',
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

Future<void> validateOrder(String orderId) async {
  final uri =  Uri.parse("${baseUrl}orders/$orderId");
  debugPrint("$uri");

  final response = await http.put(
    uri,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${ await SharedPrefsManager.getToken()}',
    },
    body: jsonEncode({
      'status': "validate",
    }),
  );
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('${response.body}');
  }
}

