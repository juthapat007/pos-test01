import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/models/category.dart';

class AddProductForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;
  final List<Category> categories;
  final Category? selectedCategory;
  final bool isSaving;
  final Function(Category?) onCategoryChanged;
  final VoidCallback onCreateProduct;

  const AddProductForm({
    super.key,
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
