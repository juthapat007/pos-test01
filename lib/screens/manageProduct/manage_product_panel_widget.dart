import 'package:flutter/material.dart';
import 'package:flutter_application_2/config/cons.dart';
import 'package:flutter_application_2/enums/btn_variant.dart';
import 'package:flutter_application_2/models/sku_master.dart';
import 'package:flutter_application_2/screens/menu_bar/menu_button.dart';
import '../common/common_widgets.dart';
// import 'manage_product_controller.dart';
import 'widgets/product_list_item.dart';

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
                AppButton(
                  text: 'Add Product',
                  variant: BtnVariant.choose,
                  icon: Icons.add,

                  onPressed: onAddPressed,
                ),
                // ElevatedButton.icon(
                //   onPressed: onAddPressed,
                //   icon: const Icon(Icons.add),
                //   label: const Text('Add Product'),
                // ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: onRefresh,
                ),
              ],
            ),
            SizedBox(height: HeightSpacing.hs),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductListItem(
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
