import 'package:deliveryz_front/utils/shared_prefs_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var baseUrl = 'http://localhost:3000/accounts/';

Future<void> login(String email, String password, String role) async {
  Uri url;
  switch (role) {
    case "Client":
      url = Uri.parse("${baseUrl}clients/login");
      break;
    case "Livreur":
      url = Uri.parse("${baseUrl}deliverers/login");
      break;
    case "Restaurant":
      url = Uri.parse("${baseUrl}cookers/login");
      break;
    default:
      url = Uri.parse("${baseUrl}clients/login");
  }
  try {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    var token = jsonDecode(response.body)['accessToken'];
    await SharedPrefsManager.logUser(token, role);
    
  } catch (e) {
    throw Exception(e.toString());
  }
}
