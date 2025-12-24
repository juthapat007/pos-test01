import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/receipt_item.dart';
import '../config/api_config.dart';

class ReceiptDetailService {
  // Fixed: Changed return type from List<Receipt> to List<ReceiptItems>
  static Future<List<ReceiptItems>> fetchReceiptItems(
    String token,
    int receiptId,
  ) async {
    final response = await http.get(
      Uri.parse('$baseUrl/receipts/$receiptId/items'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load receipt items');
    }

    final List data = jsonDecode(response.body);
    return data.map((e) => ReceiptItems.fromJson(e)).toList();
  }
}
