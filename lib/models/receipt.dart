class Receipt {
  final int id;
  final String receiptNo;
  final double totalSummary;
  final int totalAmount;
  final DateTime? createdAt;

  Receipt({
    required this.id,
    required this.receiptNo,
    required this.totalSummary,
    required this.totalAmount,
    this.createdAt,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) {
    final rawDate = json['created_at_thai'];
    print('RAW DATE FROM API: ${json['created_at_thai']}');
    print('RECEIPT ID: ${json['id']}');

    return Receipt(
      id: json['id'],
      
      receiptNo: json['receipt_no'],

      totalSummary: double.parse(json['total_summary'].toString()),
      totalAmount: json['total_amount'],
      createdAt: DateTime.parse(json['created_at_thai']),
    );
  }
}
