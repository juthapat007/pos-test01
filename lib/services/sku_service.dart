// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/sku_master.dart';
// import '../config/api_config.dart';
// import 'package:flutter_application_2/services/category_service.dart';

// class SkuService {
//   static Future<List<SkuMaster>> fetchSkuMasters(String token) async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/sku_masters'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       final List data = jsonDecode(response.body);
//       return data.map((e) => SkuMaster.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }

//   static Future<SkuMaster> createSkuMaster(
//     String token, {
//     required String name,
//     required double price,
//     required int categoryId, // ✅ เปลี่ยนเป็น int
//   }) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/sku_masters'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode({
//         'sku_master': {
//           'name': name,
//           'price': price,
//           'category_id': categoryId, // ส่งเป็น int ได้เลย
//         },
//       }),
//     );

//     if (response.statusCode == 201 || response.statusCode == 200) {
//       return SkuMaster.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception(response.body);
//     }
//   }

//   static Future<void> deleteSkuMaster(String token, int id) async {
//     final response = await http.delete(
//       Uri.parse('$baseUrl/sku_masters/$id'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//     );

//     if (response.statusCode != 200 && response.statusCode != 204) {
//       throw Exception(
//         'Failed to delete product: ${response.statusCode} ${response.body}',
//       );
//     }
//   }

//   static Future<SkuMaster> updateSkuMaster(
//     String token,
//     int id, {
//     required String name,
//     required double price,
//     required int categoryId, // ✅ เพิ่ม
//   }) async {
//     final response = await http.put(
//       Uri.parse('$baseUrl/sku_masters/$id'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'sku_master': {
//           'name': name,
//           'price': price,
//           'category_id': categoryId, // ✅
//         },
//       }),
//     );

//     if (response.statusCode == 200) {
//       return SkuMaster.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to update product');
//     }
//   }
// }
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

    print('=== SKU MASTERS RESPONSE ===');
    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');
    print('BODY TYPE: ${response.body.runtimeType}');

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      print('DECODED TYPE: ${data.runtimeType}');
      print('DECODED DATA: $data');

      // ✅ เช็คว่าเป็น Array หรือ Object
      if (data is List) {
        print('✅ Data is List - Processing directly');
        return data.map((e) => SkuMaster.fromJson(e)).toList();
      } else if (data is Map) {
        print('⚠️ Data is Map - Keys: ${data.keys}');

        // ลองหา key ที่เป็น Array
        if (data.containsKey('sku_masters')) {
          print('✅ Found key: sku_masters');
          final List items = data['sku_masters'];
          return items.map((e) => SkuMaster.fromJson(e)).toList();
        } else if (data.containsKey('data')) {
          print('✅ Found key: data');
          final List items = data['data'];
          return items.map((e) => SkuMaster.fromJson(e)).toList();
        } else {
          print('❌ No array key found. Available keys: ${data.keys}');
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

    print('=== CREATE SKU RESPONSE ===');
    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

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

    print('=== DELETE SKU RESPONSE ===');
    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

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

    print('=== UPDATE SKU RESPONSE ===');
    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

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
}
