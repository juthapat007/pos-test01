import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/models/category.dart';
import 'package:flutter_application_2/models/sku_master.dart';

class EditProductForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;
  final List<Category> categories;
  final Category? selectedCategory;
  final SkuMaster? selectedProduct;
  final bool isSaving;
  final Function(Category?) onCategoryChanged;
  final VoidCallback onUpdateProduct;

  const EditProductForm({
    super.key,
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
          items: categories
              .map((c) => DropdownMenuItem(value: c, child: Text(c.name)))
              .toList(),
          onChanged: onCategoryChanged,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: priceController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
          ],
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
