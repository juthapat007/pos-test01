import 'dart:convert';

import 'package:flutter_application_2/config/api_config.dart';
import 'package:http/http.dart' as http;

class CartItemService {
  static Future<void> addToCartItem({
    required String token,
    required int skuMasterId,
    required int quantity,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cart_items'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'cart_item': {'sku_master_id': skuMasterId, 'quantity': quantity},
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add cart item');
    }
  }
}
