import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/receipt_item.dart';
import '../config/api_config.dart';
import 'package:flutter_application_2/services/receipt_service.dart';
import 'package:flutter_application_2/services/receipt_item_service.dart';

class ReceiptItemService {
  static Future<List<ReceiptItems>> fetchByReceipt(
    String token,
    int receiptId,
  ) async {
    final res = await http.get(
      Uri.parse('$baseUrl/receipts/$receiptId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      final List items = json['receipt_items'];

      return items.map((e) => ReceiptItems.fromJson(e)).toList();
    } else {
      throw Exception('Load receipt items failed');
    }
  }
}
