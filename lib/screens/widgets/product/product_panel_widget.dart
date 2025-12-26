import 'dart:async';
import 'package:flutter_application_2/config/cons.dart';

import '../common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/sku_master.dart';
import '../common_widgets.dart';
import 'product_card.dart';

class ProductPanelWidget extends StatefulWidget {
  final List<SkuMaster> products;
  final bool isLoading;
  final Function(SkuMaster) onProductTap;
  final Function(String keyword) onSearch; // 👈 ส่ง callback ขึ้น parent

  const ProductPanelWidget({
    super.key,
    required this.products,
    required this.isLoading,
    required this.onProductTap,
    required this.onSearch,
  });

  @override
  State<ProductPanelWidget> createState() => _ProductPanelWidgetState();
}

class _ProductPanelWidgetState extends State<ProductPanelWidget> {
  Timer? _debounce;

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onSearch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: CommonWidgets.boxStyle(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Products',
              style: TextStyle(
                fontSize: AppSpacing.lg,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.md),
            TextField(
              maxLength: 20,
              decoration: const InputDecoration(
                counterText: "",
                labelText: "ค้นหา",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _onSearchChanged, // ✅ debounce
            ),

            const SizedBox(height: 12),

            Expanded(
              child: widget.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.2,
                          ),
                      itemCount: widget.products.length,
                      itemBuilder: (context, index) {
                        final product = widget.products[index];
                        return ProductCard(
                          product: product,
                          onTap: () => widget.onProductTap(product),
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
