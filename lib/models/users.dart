import 'dart:convert';
import 'package:flutter_application_2/config/api_config.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // GET request
  Future<List<dynamic>> getUsers() async {
    final response = await http.get(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['users'];
    } else {
      throw Exception('Failed to load users');
    }
  }

  // POST request
  Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create user');
    }
  }
}
