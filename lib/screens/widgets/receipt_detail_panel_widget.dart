// import 'package:flutter/material.dart';
// import 'package:flutter_application_2/services/receipt_service.dart';

// /// Widget สำหรับแสดงรายละเอียดใบเสร็จ/บิล
// /// ใช้แสดงข้อมูลเมื่อเลือกใบเสร็จจาก OrderListPanel
// class ReceiptDetailPanelWidget extends StatelessWidget {
//   final int receiptId;
//   final String token;

//   const ReceiptDetailPanelWidget({
//     super.key,
//     required this.receiptId,
//     required this.token,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<ReceiptItems>>(
//       future: ReceiptDetailService.fetchReceiptItems(
//         token,
//         receiptId, // ✅ ครบ 2 ตัว
//       ),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text('No items in this receipt'));
//         }

//         final items = snapshot.data!;

//         return ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             final item = items[index];
//             return ListTile(
//               title: Text(item.name),
//               trailing: Text('x${item.quantity}'),
//               subtitle: Text('฿${item.price}'),
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/receipt_service.dart';
import 'package:flutter_application_2/models/receipt_item.dart'; // Add this import

/// Widget สำหรับแสดงรายละเอียดใบเสร็จ/บิล
/// ใช้แสดงข้อมูลเมื่อเลือกใบเสร็จจาก OrderListPanel
class ReceiptDetailPanelWidget extends StatelessWidget {
  final int receiptId;
  final String token;

  const ReceiptDetailPanelWidget({
    super.key,
    required this.receiptId,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FutureBuilder<List<ReceiptItems>>(
          future: ReceiptDetailService.fetchReceiptItems(token, receiptId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inbox, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No items in this receipt',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            final items = snapshot.data!;
            final totalAmount = items.fold<double>(
              0,
              (sum, item) => sum + item.subtotal,
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Receipt Details #$receiptId',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(height: 32),

                // Items List
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(
                            item.name,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            '฿${item.price.toStringAsFixed(2)} × ${item.quantity}',
                          ),
                          trailing: Text(
                            '฿${item.subtotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Total
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '฿${totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
