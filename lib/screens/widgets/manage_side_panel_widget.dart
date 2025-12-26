import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/category.dart';
import 'package:flutter_application_2/models/sku_master.dart';
import '../product_item.dart';
import 'common_widgets.dart';

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
          ManageMode.add => _AddProductForm(
            nameController: nameController,
            priceController: priceController,
            categories: categories,
            selectedCategory: selectedCategory,
            isSaving: isSaving,
            onCategoryChanged: onCategoryChanged,
            onCreateProduct: onCreateProduct,
          ),
          ManageMode.edit => _EditProductForm(
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
              'Select product or add new',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        },
      ),
    );
  }
}

class _AddProductForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;
  final List<Category> categories;
  final Category? selectedCategory;
  final bool isSaving;
  final Function(Category?) onCategoryChanged;
  final VoidCallback onCreateProduct;

  const _AddProductForm({
    required this.nameController,
    required this.priceController,
    required this.categories,
    required this.selectedCategory,
    required this.isSaving,
    required this.onCategoryChanged,
    required this.onCreateProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add New Product',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Product Name'),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<Category>(
          value: selectedCategory,
          hint: const Text('Select Category'),
          items: categories.map((c) {
            return DropdownMenuItem(value: c, child: Text(c.name));
          }).toList(),
          onChanged: onCategoryChanged,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: priceController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Price'),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isSaving ? null : onCreateProduct,
            child: isSaving
                ? const CircularProgressIndicator()
                : const Text('Create Product'),
          ),
        ),
      ],
    );
  }
}

class _EditProductForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;
  final List<Category> categories;
  final Category? selectedCategory;
  final SkuMaster? selectedProduct;
  final bool isSaving;
  final Function(Category?) onCategoryChanged;
  final VoidCallback onUpdateProduct;

  const _EditProductForm({
    required this.nameController,
    required this.priceController,
    required this.categories,
    required this.selectedCategory,
    required this.selectedProduct,
    required this.isSaving,
    required this.onCategoryChanged,
    required this.onUpdateProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          'Edit Product',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Product Name'),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<Category>(
          value: selectedCategory,
          hint: const Text('Select Category'),
          items: categories.map((c) {
            return DropdownMenuItem(value: c, child: Text(c.name));
          }).toList(),
          onChanged: onCategoryChanged,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: priceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Price',
            hintText: selectedProduct != null
                ? '฿${selectedProduct!.price}'
                : '',
          ),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isSaving ? null : onUpdateProduct,
            child: isSaving
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : const Text('Update Product'),
          ),
        ),
      ],
    );
  }
}
