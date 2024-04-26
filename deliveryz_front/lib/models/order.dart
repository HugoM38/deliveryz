class Order {
  final int quantity;
  final double totalPrice;
  final String clientId;
  final String cookerId;
  final String productName;
  final String? status;

  Order({
    required this.quantity,
    required this.totalPrice,
    required this.clientId,
    required this.cookerId,
    required this.productName,
    this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      quantity: json['quantity'],
      totalPrice: json['totalPrice']?.toDouble(),
      clientId: json['clientId'],
      cookerId: json['cookerId'],
      productName: json['productName'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'totalPrice': totalPrice,
      'clientId': clientId,
      'cookerId': cookerId,
      'productName': productName,
      'status': status,
    };
  }
}
