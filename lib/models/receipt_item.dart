import 'package:flutter_application_2/models/receipt.dart';

class ReceiptItem {
  final int id;
  final int receipt;
  final int skuMasterId;
  // final String name;
  final double price;
  final int quantity;
  // final double subtotal;

  ReceiptItem({
    required this.id,
    required this.receipt,
    required this.skuMasterId,
    // required this.name,
    required this.price,
    required this.quantity,
    // required this.subtotal,
  });

  factory ReceiptItem.fromJson(Map<String, dynamic> json) {
    return ReceiptItem(
      id: json['id'],
      receipt: json['receipt_id'],
      skuMasterId: json['sku_master_id'],
      // name: json['name'],
      price: double.parse(json['price'].toString()),
      quantity: json['quantity'],
      // subtotal: double.parse(json['subtotal'].toString()),
    );
  }
}
