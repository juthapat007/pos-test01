// lib/models/receipt.dart
class Receipt {
  final int id;
  final String receiptNo;
  final double totalSummary;
  final int totalAmount;
  final DateTime createdAt;

  Receipt({
    required this.id,
    required this.receiptNo,
    required this.totalSummary,
    required this.totalAmount,
    required this.createdAt,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return Receipt(
      id: json['id'],
      receiptNo: json['receipt_no'],
      totalSummary: double.parse(json['total_summary'].toString()),
      totalAmount: json['total_amount'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
