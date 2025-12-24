import 'package:flutter_application_2/models/category.dart';

class SkuMaster {
  final int id;
  final String name;
  final double price;
  final int categoryId;

  SkuMaster({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryId,
  });

  factory SkuMaster.fromJson(Map<String, dynamic> json) {
    return SkuMaster(
      id: json['id'],
      name: json['name'],
      price: json['price'] is String
          ? double.parse(json['price'])
          : (json['price'] as num).toDouble(),
      categoryId: json['category_id'] is String
          ? int.parse(json['category_id'])
          : json['category_id'],
    );
  }
}
