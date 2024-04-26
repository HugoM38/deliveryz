abstract class User {
  final String? id;
  final String email;
  final String password;
  final String address;
  final String city;
  final String postalCode;
  final String phoneNumber;

  User({
    this.id,
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
    super.id,
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
      id: json['id'],
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
      'id': id,
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
    super.id,
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
      id: json['id'],
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
      'id': id,
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
    super.id,
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
      id: json['id'],
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
      'id': id,
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
