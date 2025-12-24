// class Receipt {
//   final int id;
//   final String receiptNo;
//   final double totalSummary;
//   final int totalAmount;
//   final DateTime createdAt;

//   Receipt({
//     required this.id,
//     required this.receiptNo,
//     required this.totalSummary,
//     required this.totalAmount,
//     required this.createdAt,
//   });

//   factory Receipt.fromJson(Map<String, dynamic> json) {
//     return Receipt(
//       id: json['id'],
//       receiptNo: json['receipt_no'],
//       totalSummary: double.parse(json['total_summary'].toString()),
//       totalAmount: json['total_amount'],
//       createdAt: DateTime.parse(json['created_at']),
//     );
//   }
// }

// Create this new file: lib/models/receipt_items.dart

class ReceiptItems {
  final int id;
  final int receiptId;
  final int skuMasterId;
  final String name;
  final double price;
  final int quantity;
  final double subtotal;

  ReceiptItems({
    required this.id,
    required this.receiptId,
    required this.skuMasterId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.subtotal,
  });

  factory ReceiptItems.fromJson(Map<String, dynamic> json) {
    return ReceiptItems(
      id: json['id'],
      receiptId: json['receipt_id'],
      skuMasterId: json['sku_master_id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      quantity: json['quantity'],
      subtotal: double.parse(json['subtotal'].toString()),
    );
  }
}
