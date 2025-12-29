import 'package:flutter/material.dart';
import 'package:flutter_application_2/config/cons.dart';
import 'package:flutter_application_2/models/sku_master.dart' show SkuMaster;
import 'package:flutter_application_2/services/receipt_item_service.dart'; // ✅ ใช้ receipt_item_service.dart
import 'package:flutter_application_2/models/receipt_item.dart';
import 'package:flutter_application_2/utils/sku_helper.dart';
import 'package:flutter_application_2/models/receipt.dart';
import '';

// Widget สำหรับแสดงรายละเอียดใบเสร็จ/บิล
// ใช้แสดงข้อมูลเมื่อเลือกใบเสร็จจาก OrderListPanel

class ReceiptDetailPanelWidget extends StatelessWidget {
  final Receipt receipt;

  final String token;
  final List<SkuMaster> skuMasters;

  const ReceiptDetailPanelWidget({
    super.key,
    required this.receipt,
    required this.token,
    required this.skuMasters,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,

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

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Receipt Details',
              style: TextStyle(
                fontSize: TextSpacing.lg,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(height: TextSpacing.lg),
            Text(
              receipt.receiptNo,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: FutureBuilder<List<ReceiptItem>>(
                future: ReceiptItemService.fetchByReceiptId(token, receipt.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final items = snapshot.data ?? [];

                  if (items.isEmpty) {
                    return const Center(
                      child: Text('No items in this receipt'),
                    );
                  }

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];

                      final skuName = SkuHelper.getSkuName(
                        skuId: item.skuMasterId,
                        skus: skuMasters,
                      );

                      return ListTile(
                        title: Text(
                          skuName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Amount: ${item.quantity}'),
                        trailing: Text(
                          '฿${(item.quantity * item.price).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      );
                    },
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
