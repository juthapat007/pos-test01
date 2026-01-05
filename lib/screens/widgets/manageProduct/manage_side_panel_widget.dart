import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/category.dart';
import 'package:flutter_application_2/models/sku_master.dart';
import 'package:flutter_application_2/screens/product_item.dart';
import 'package:flutter_application_2/screens/widgets/common/common_widgets.dart';

import 'add_product_form.dart';
import 'edit_product_form.dart';

class ManageSidePanelWidget extends StatelessWidget {
  final ManageMode manageMode;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final List<Category> categories;
  final Category? selectedCategory;
  final SkuMaster? selectedProduct;
  final bool isSaving;
  final Function(Category?) onCategoryChanged;
  final VoidCallback onCreateProduct;
  final VoidCallback onUpdateProduct;

  const ManageSidePanelWidget({
    super.key,
    required this.manageMode,
    required this.nameController,
    required this.priceController,
    required this.categories,
    required this.selectedCategory,
    required this.selectedProduct,
    required this.isSaving,
    required this.onCategoryChanged,
    required this.onCreateProduct,
    required this.onUpdateProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: CommonWidgets.boxStyle(),
        child: switch (manageMode) {
          ManageMode.add => AddProductForm(
              nameController: nameController,
              priceController: priceController,
              categories: categories,
              selectedCategory: selectedCategory,
              isSaving: isSaving,
              onCategoryChanged: onCategoryChanged,
              onCreateProduct: onCreateProduct,
            ),
          ManageMode.edit => EditProductForm(
              nameController: nameController,
              priceController: priceController,
              categories: categories,
              selectedCategory: selectedCategory,
              selectedProduct: selectedProduct,
              isSaving: isSaving,
              onCategoryChanged: onCategoryChanged,
              onUpdateProduct: onUpdateProduct,
            ),
          ManageMode.none => const Center(
              child: Text(
                'Edit and Add Product',
                style: TextStyle(color: Colors.grey),
              ),
            ),
        },
      ),
    );
  }
}
