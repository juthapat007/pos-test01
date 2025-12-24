import 'package:flutter_application_2/models/sku_master.dart';

class CartItem {
  final SkuMaster product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
