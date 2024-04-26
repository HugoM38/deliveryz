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
 var id = jsonDecode(response.body)['id'];
    var token = jsonDecode(response.body)['accessToken'];
    await SharedPrefsManager.logUser(token, role, id);

  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<void> signup(
    String email,
    String password,
    String role,
    String firstname,
    String lastname,
    String address,
    String city,
    String postalCode,
    String phoneNumber) async {
  Uri url;
  switch (role) {
    case "Client":
      url = Uri.parse("${baseUrl}clients/");
      break;
    case "Livreur":
      url = Uri.parse("${baseUrl}deliverers/");
      break;
    case "Restaurant":
      url = Uri.parse("${baseUrl}cookers/");
      break;
    default:
      url = Uri.parse("${baseUrl}clients/");
  }
  try {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'firstname': firstname,
        'lastname': lastname,
        'address': address,
        'city': city,
        'postalCode': postalCode,
        'phoneNumber': phoneNumber
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    var token = jsonDecode(response.body)['accessToken'];
    var id = jsonDecode(response.body)['id'];
    await SharedPrefsManager.logUser(token, role, id);
  } catch (e) {
    throw Exception(e.toString());
  }
}
