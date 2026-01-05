import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/sku_master.dart';
import 'package:flutter_application_2/screens/widgets/common/common_widgets.dart';
import 'package:flutter_application_2/config/cons.dart';

class ProductCard extends StatelessWidget {
  final SkuMaster product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: CommonWidgets.boxStyle(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 ชื่อสินค้า
              Text(
                product.name ?? 'ไม่ระบุชื่อสินค้า',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: Spacing.sm),

              // 🔹 ราคา
              Text(
                '฿${product.price?.toStringAsFixed(2) ?? '-'}',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.green[700],
                  fontWeight: FontWeight.w600,
                ),
              ),

              const Spacer(),

              // 🔹 hint เล็ก ๆ ด้านล่าง (optional)
              Text(
                'แตะเพื่อเลือก',
                style: TextStyle(fontSize: 11, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
