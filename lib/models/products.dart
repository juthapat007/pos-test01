import 'package:flutter_application_2/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // เปลี่ยนเป็น IP ของเครื่อง Rails

  // ตัวอย่างการเรียก API
  Future<List<dynamic>> getUsers() async {
    final response = await http.get(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  // ตัวอย่าง POST
  Future<dynamic> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Login failed');
    }
  }
}
