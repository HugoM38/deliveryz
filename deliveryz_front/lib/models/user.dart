abstract class User {
  final String email;
  final String password;
  final String address;
  final String city;
  final String postalCode;
  final String phoneNumber;

  User({
    required this.email,
    required this.password,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson();
}

class Client extends User {
  final String firstName;
  final String lastName;

  Client({
    required this.firstName,
    required this.lastName,
    required super.email,
    required super.password,
    required super.address,
    required super.city,
    required super.postalCode,
    required super.phoneNumber,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      city: json['city'],
      postalCode: json['postalCode'],
      phoneNumber: json['phoneNumber'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'address': address,
      'city': city,
      'postalCode': postalCode,
      'phoneNumber': phoneNumber,
    };
  }
}

class Cooker extends User {
  final String cookerName;
  final List menu;

  Cooker({
    required this.cookerName,
    required this.menu,
    required super.email,
    required super.password,
    required super.address,
    required super.city,
    required super.postalCode,
    required super.phoneNumber,
  });

  factory Cooker.fromJson(Map<String, dynamic> json) {
    return Cooker(
      cookerName: json['cookerName'],
      menu: json['menu'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      city: json['city'],
      postalCode: json['postalCode'],
      phoneNumber: json['phoneNumber'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'cookerName': cookerName,
      'menu': menu,
      'email': email,
      'password': password,
      'address': address,
      'city': city,
      'postalCode': postalCode,
      'phoneNumber': phoneNumber,
    };
  }
}

class Deliverer extends User {
  final String firstName;
  final String lastName;

  Deliverer({
    required this.firstName,
    required this.lastName,
    required super.email,
    required super.password,
    required super.address,
    required super.city,
    required super.postalCode,
    required super.phoneNumber,
  });

  factory Deliverer.fromJson(Map<String, dynamic> json) {
    return Deliverer(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      city: json['city'],
      postalCode: json['postalCode'],
      phoneNumber: json['phoneNumber'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'address': address,
      'city': city,
      'postalCode': postalCode,
      'phoneNumber': phoneNumber,
    };
  }
}
