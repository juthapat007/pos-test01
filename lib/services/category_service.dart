import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/category.dart';

class CategoryService {
  static Future<List<Category>> fetchCategories(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/categories'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print('=== CATEGORIES RESPONSE ===');
    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      print('DECODED TYPE: ${data.runtimeType}');

      if (data is List) {
        return data.map((e) => Category.fromJson(e)).toList();
      } else if (data is Map) {
        if (data.containsKey('categories')) {
          final List items = data['categories'];
          return items.map((e) => Category.fromJson(e)).toList();
        } else if (data.containsKey('data')) {
          final List items = data['data'];
          return items.map((e) => Category.fromJson(e)).toList();
        }

        throw Exception('Unexpected JSON format. Keys: ${data.keys}');
      }

      throw Exception('Unknown data type: ${data.runtimeType}');
    }

    throw Exception('Failed to load categories');
  }
}
