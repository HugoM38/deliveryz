class Order {
  final String id;
  final int? quantity;
  final double? totalPrice;
  final String? clientId;
  final String? cookerId;
  final String? productName;
  final String? status;
  final String? customerEmail;
  final String? shippingAddress;
  final String? contactPhone;
  final String? customerName;

  Order({
    required this.id,
    this.quantity,
    this.totalPrice,
    this.clientId,
    this.cookerId,
    this.productName,
    this.status,
    this.customerEmail,
    this.shippingAddress,
    this.contactPhone,
    this.customerName,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice']?.toDouble(),
      clientId: json['clientId'],
      cookerId: json['cookerId'],
      productName: json['productName'],
      status: json['status'],
      customerEmail: json['customerEmail'],
      shippingAddress: json['shippingAddress'],
      contactPhone: json['contactPhone'],
      customerName: json['customerName'],
    );
  }
}
