// lib/services/receipt_item_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/receipt_item.dart';
import '../config/api_config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/receipt_item.dart';

class ReceiptItemService {
  static Future<List<ReceiptItem>> fetchByReceiptId(
    String token,
    int receiptId,
  ) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/receipt_items/receipt_items_by_receipt?receipt_id=$receiptId',
      ),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load receipt items');
    }

    final List<dynamic> data = json.decode(response.body);
    return data.map((e) => ReceiptItem.fromJson(e)).toList();
  }
}
