import 'dart:convert';

import 'package:http/http.dart' as http;

var baseUrl = 'http://localhost:3000/kitchens/';

Future<List<List<String>>> getMenu(String cookerId) async {
  Uri url = Uri.parse("${baseUrl}menu/$cookerId");
  try {
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return jsonDecode(response.body);
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<void> addMenu(String cookerId, String item, double price) async {
  Uri url = Uri.parse("${baseUrl}menu/$cookerId");
  try {
    List<List<String>> menu = await getMenu(cookerId);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'menu': [...menu,[menu.length,item,price]]}),
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return jsonDecode(response.body);
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<void> removeMenu(String cookerId, String item, double price, int index) async {
  Uri url = Uri.parse("${baseUrl}menu/$cookerId");
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
