// lib/services/receipt_item_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/receipt_item.dart';
import '../config/api_config.dart';

class ReceiptItemService {
  /// ดึงรายการสินค้าในใบเสร็จ (receipt items)
  static Future<List<ReceiptItems>> fetchReceiptItems(
    String token,
    int receiptId,
  ) async {
    final response = await http.get(
      Uri.parse('$baseUrl/receipts/$receiptId/items'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print('=== RECEIPT ITEMS RESPONSE ===');
    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      print('DECODED TYPE: ${data.runtimeType}');

      // ถ้า response เป็น List
      if (data is List) {
        return data.map((e) => ReceiptItems.fromJson(e)).toList();
      }

      // ถ้า response เป็น Map
      if (data is Map) {
        if (data.containsKey('receipt_items')) {
          final List items = data['receipt_items'];
          return items.map((e) => ReceiptItems.fromJson(e)).toList();
        } else if (data.containsKey('items')) {
          final List items = data['items'];
          return items.map((e) => ReceiptItems.fromJson(e)).toList();
        } else if (data.containsKey('data')) {
          final List items = data['data'];
          return items.map((e) => ReceiptItems.fromJson(e)).toList();
        }

        throw Exception('Unexpected JSON format. Keys: ${data.keys}');
      }

      throw Exception('Unknown data type: ${data.runtimeType}');
    }

    throw Exception('Failed to load receipt items: ${response.statusCode}');
  }
}
