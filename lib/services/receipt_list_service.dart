// lib/services/receipt_list_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/receipt.dart';
import '../config/api_config.dart';

class ReceiptListService {
  static Future<List<Receipt>> fetchReceipts(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/receipts'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print('=== RECEIPTS RESPONSE ===');
    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      print('DECODED TYPE: ${data.runtimeType}');

      // ถ้า response เป็น List
      if (data is List) {
        return data.map((e) => Receipt.fromJson(e)).toList();
      }

      // ถ้า response เป็น Map
      if (data is Map) {
        // ลองหา key ที่เป็น Array
        if (data.containsKey('receipts')) {
          final List items = data['receipts'];
          return items.map((e) => Receipt.fromJson(e)).toList();
        } else if (data.containsKey('data')) {
          final List items = data['data'];
          return items.map((e) => Receipt.fromJson(e)).toList();
        }

        throw Exception('Unexpected JSON format. Keys: ${data.keys}');
      }

      throw Exception('Unknown data type: ${data.runtimeType}');
    }

    throw Exception('Failed to load receipts: ${response.statusCode}');
  }
}
