import 'package:http/http.dart' as http;
import 'dart:convert';

var baseUrl = 'http://localhost:3000/accounts/';

Future<void> clientLogin(String email, String password) async {
  try {
    var response = await http.post(
      Uri.parse("${baseUrl}clients/login"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
