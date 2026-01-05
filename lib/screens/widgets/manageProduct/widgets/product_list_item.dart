import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/sku_master.dart';
import '../../../widgets/common/common_widgets.dart';

class ProductListItem extends StatelessWidget {
  final SkuMaster product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductListItem({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: CommonWidgets.boxStyle(),
      child: ListTile(
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('฿${product.price}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
            IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
          ],
        ),
      ),
    );
  }
}
