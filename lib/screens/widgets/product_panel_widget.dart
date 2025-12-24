import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/sku_master.dart';
import 'common_widgets.dart';

class ProductPanelWidget extends StatelessWidget {
  final List<SkuMaster> products;
  final bool isLoading;
  final Function(SkuMaster) onProductTap;

  const ProductPanelWidget({
    super.key,
    required this.products,
    required this.isLoading,
    required this.onProductTap,
  });

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
            TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/ProductItem');
              },
            ),
            const Text(
              'Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.2,
                          ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return _ProductCard(
                          product: product,
                          onTap: () => onProductTap(product),
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

class _ProductCard extends StatelessWidget {
  final SkuMaster product;
  final VoidCallback onTap;

  const _ProductCard({required this.product, required this.onTap});

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
