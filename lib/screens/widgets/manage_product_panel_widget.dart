import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/receipt_item.dart';
import 'package:flutter_application_2/models/sku_master.dart';
import 'package:flutter_application_2/services/receipt_item_service.dart';
import 'common_widgets.dart';

class ManageProductPanelWidget extends StatelessWidget {
  final List<SkuMaster> products;
  final VoidCallback onAddPressed;
  final Function(SkuMaster) onEditPressed;
  final Function(SkuMaster) onDeletePressed;
  final VoidCallback onRefresh;

  const ManageProductPanelWidget({
    super.key,
    required this.products,
    required this.onAddPressed,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: CommonWidgets.boxStyle(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Manage Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: onAddPressed,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Product'),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: onRefresh,
                  tooltip: 'Reload',
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _ProductListItem(
                    product: product,
                    onEdit: () => onEditPressed(product),
                    onDelete: () => onDeletePressed(product),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductListItem extends StatelessWidget {
  final SkuMaster product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ProductListItem({
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
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
