import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sku_master.dart';
import '../config/api_config.dart';

class SkuService {
  static Future<List<SkuMaster>> fetchSkuMasters(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/sku_masters'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    // print('=== SKU MASTERS RESPONSE ===');
    // print('STATUS: ${response.statusCode}');
    // print('BODY: ${response.body}');
    // print('BODY TYPE: ${response.body.runtimeType}');

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      // print('DECODED TYPE: ${data.runtimeType}');
      // print('DECODED DATA: $data');

      // ✅ เช็คว่าเป็น Array หรือ Object
      if (data is List) {
        // print('✅ Data is List - Processing directly');
        return data.map((e) => SkuMaster.fromJson(e)).toList();
      } else if (data is Map) {
        // print('⚠️ Data is Map - Keys: ${data.keys}');

        // ลองหา key ที่เป็น Array
        if (data.containsKey('sku_masters')) {
          // print('✅ Found key: sku_masters');
          final List items = data['sku_masters'];
          return items.map((e) => SkuMaster.fromJson(e)).toList();
        } else if (data.containsKey('data')) {
          // print('✅ Found key: data');
          final List items = data['data'];
          return items.map((e) => SkuMaster.fromJson(e)).toList();
        } else {
          // print('❌ No array key found. Available keys: ${data.keys}');
          throw Exception('Unexpected JSON format. Keys: ${data.keys}');
        }
      }

      throw Exception('Unknown data type: ${data.runtimeType}');
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }

  static Future<SkuMaster> createSkuMaster(
    String token, {
    required String name,
    required double price,
    required int categoryId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sku_masters'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'sku_master': {'name': name, 'price': price, 'category_id': categoryId},
      }),
    );

    // print('=== CREATE SKU RESPONSE ===');
    // print('STATUS: ${response.statusCode}');
    // print('BODY: ${response.body}');

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Rails อาจจะ wrap ใน key 'sku_master' หรือไม่ก็ได้
      if (data is Map && data.containsKey('sku_master')) {
        return SkuMaster.fromJson(data['sku_master']);
      }
      return SkuMaster.fromJson(data);
    } else {
      throw Exception('Failed to create: ${response.body}');
    }
  }

  static Future<void> deleteSkuMaster(String token, int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/sku_masters/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // print('=== DELETE SKU RESPONSE ===');
    // print('STATUS: ${response.statusCode}');
    // print('BODY: ${response.body}');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception(
        'Failed to delete product: ${response.statusCode} ${response.body}',
      );
    }
  }

  static Future<SkuMaster> updateSkuMaster(
    String token,
    int id, {
    required String name,
    required double price,
    required int categoryId,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/sku_masters/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'sku_master': {'name': name, 'price': price, 'category_id': categoryId},
      }),
    );

    // print('=== UPDATE SKU RESPONSE ===');
    // print('STATUS: ${response.statusCode}');
    // print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Rails อาจจะ wrap ใน key 'sku_master' หรือไม่ก็ได้
      if (data is Map && data.containsKey('sku_master')) {
        return SkuMaster.fromJson(data['sku_master']);
      }
      return SkuMaster.fromJson(data);
    } else {
      throw Exception('Failed to update product: ${response.body}');
    }
  }

  static Future<List<SkuMaster>> searchSkuMasters(
    String token,
    String keyword,
  ) async {
    final uri = Uri.parse(
      '$baseUrl/sku_masters/search?keyword=${Uri.encodeQueryComponent(keyword)}',
    );

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    // print('=== SEARCH SKU RESPONSE ===');
    // print('STATUS: ${response.statusCode}');
    // print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // reuse logic เดิม
      if (data is List) {
        return data.map((e) => SkuMaster.fromJson(e)).toList();
      } else if (data is Map && data.containsKey('sku_masters')) {
        final List items = data['sku_masters'];
        return items.map((e) => SkuMaster.fromJson(e)).toList();
      }

      throw Exception('Unexpected search response format');
    } else {
      throw Exception('Search failed: ${response.statusCode}');
    }
  }
}
