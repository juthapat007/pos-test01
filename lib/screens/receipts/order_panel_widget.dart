// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/cartitem.dart';
import 'package:flutter_application_2/screens/common/common_widgets.dart';

class OrderPanelWidget extends StatelessWidget {
  final List<CartItem> cart;
  final double totalPrice;
  final VoidCallback onCancel;
  final VoidCallback onPay;
  final Function(CartItem) onRemoveItem;

  const OrderPanelWidget({
    super.key,
    required this.cart,
    required this.totalPrice,
    required this.onCancel,
    required this.onPay,
    required this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: CommonWidgets.boxStyle(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Cart',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            /// รายการสินค้า
            Expanded(
              child: cart.isEmpty
                  ? const Center(child: Text('No items in cart'))
                  : ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final item = cart[index];
                        return ListTile(
                          title: Text(item.product.name),
                          subtitle: Text(
                            '฿${item.product.price} x ${item.quantity}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => onRemoveItem(item),
                          ),
                        );
                      },
                    ),
            ),

            const Divider(),

            /// ราคารวม
            Text(
              'Total: ฿${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),

            const SizedBox(height: 12),

            /// ปุ่ม
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel,
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPay,
                    child: const Text('Pay'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
