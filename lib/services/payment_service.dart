import 'package:flutter_application_2/config/api_config.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  static Future<void> payCash(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/payments/cash'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Payment failed');
    }
  }
}
