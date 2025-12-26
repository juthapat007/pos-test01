import 'package:flutter/material.dart';
import 'package:flutter_application_2/config/cons.dart';
import 'package:flutter_application_2/models/cartitem.dart';
import 'common_widgets.dart';

class OrderPanelWidget extends StatelessWidget {
  final List<CartItem> cart;
  final double totalPrice;
  final VoidCallback onCancel;
  final VoidCallback onPay;

  const OrderPanelWidget({
    super.key,
    required this.cart,
    required this.totalPrice,
    required this.onCancel,
    required this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: CommonWidgets.boxStyle(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // รายการสินค้า
            Expanded(
              child: cart.isEmpty
                  ? const Center(
                      child: Text(
                        'No items in cart',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final item = cart[index];
                        return ListTile(
                          title: Text(
                            item.product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          subtitle: Text(
                            '฿${item.product.price} x ${item.quantity}',
                          ),
                          // trailing: Text(
                          //   '฿${item.product.price * item.quantity}',
                          //   style: const TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 12,
                          //   ),
                          // ),
                        );
                      },
                    ),
            ),

            const Divider(),

            // รวมราคา
            Text(
              'Total: ฿${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: AppSpacing.lg),

            // ปุ่ม
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: cart.isEmpty ? null : onPay,
                child: const Text('Pay'),
              ),
            ),

            SizedBox(height: AppSpacing.lg),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: cart.isEmpty ? null : onCancel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                ),
                child: const Text('Cancel'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
