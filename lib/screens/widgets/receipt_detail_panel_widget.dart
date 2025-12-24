import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/sku_master.dart' show SkuMaster;
import 'package:flutter_application_2/services/receipt_item_service.dart'; // ✅ ใช้ receipt_item_service.dart
import 'package:flutter_application_2/models/receipt_item.dart';
import 'package:flutter_application_2/utils/sku_helper.dart';

// Widget สำหรับแสดงรายละเอียดใบเสร็จ/บิล
// ใช้แสดงข้อมูลเมื่อเลือกใบเสร็จจาก OrderListPanel

class ReceiptDetailPanelWidget extends StatelessWidget {
  final int receiptId;
  final String token;
  final List<SkuMaster> skuMasters;

  const ReceiptDetailPanelWidget({
    super.key,
    required this.receiptId,
    required this.token,
    required this.skuMasters,
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
        child: FutureBuilder<List<ReceiptItem>>(
          future: ReceiptItemService.fetchByReceiptId(token, receiptId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No items'));
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final items = snapshot.data!;

            if (items.isEmpty) {
              return const Center(child: Text('No items in this receipt'));
            }

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                final SkuName = SkuHelper.getSkuName(
                  skuId: item.skuMasterId,
                  skus: skuMasters,
                );

                return ListTile(
                  title: Text(
                    SkuName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    'Amout: ${item.quantity} • ${item.quantity * item.price}฿',
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
