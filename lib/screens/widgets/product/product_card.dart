import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/sku_master.dart';
import 'package:flutter_application_2/screens/widgets/common_widgets.dart';

class ProductCard extends StatelessWidget {
  final SkuMaster product;
  final VoidCallback onTap;

  const ProductCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: CommonWidgets.boxStyle(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text('฿${product.price}'),
            const SizedBox(height: 4),
            ElevatedButton(onPressed: onTap, child: const Text('เลือก')),
          ],
        ),
      ),
    );
  }
}
