import 'package:flutter/material.dart';
import 'package:flutter_application_2/config/cons.dart';
import 'package:flutter_application_2/models/receipt.dart';
import 'package:flutter_application_2/screens/common/common_widgets.dart';
import 'package:flutter_application_2/services/receipt_list_service.dart';
import 'package:flutter_application_2/screens/common/common_widgets.dart';

// Widget สำหรับแสดงรายการใบเสร็จทั้งหมด
class OrderListPanelWidget extends StatefulWidget {
  final String token;
  final Function(Receipt) onSelect;

  const OrderListPanelWidget({
    super.key,
    required this.token,
    required this.onSelect,
  });

  @override
  State<OrderListPanelWidget> createState() => _OrderListPanelWidgetState();
}

class _OrderListPanelWidgetState extends State<OrderListPanelWidget> {
  List<Receipt> receipts = [];
  bool isLoading = true;
  Receipt? selectedReceipt;

  @override
  void initState() {
    super.initState();
    loadReceipts();
  }

  Future<void> loadReceipts() async {
    setState(() => isLoading = true);

    try {
      final data = await ReceiptListService.fetchReceipts(widget.token);
      setState(() {
        receipts = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading receipts: $e');
      setState(() => isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to load receipts: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: CommonWidgets.boxStyle(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Receipt List',
                  style: TextStyle(
                    fontSize: TextSpacing.lg,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: loadReceipts,
                  tooltip: 'Refresh',
                ),
              ],
            ),
            Divider(height: TextSpacing.md),

            // Content
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : receipts.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inbox, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No receipts found',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: receipts.length,
                      itemBuilder: (context, index) {
                        final receipt = receipts[index];
                        final isSelected = selectedReceipt == receipt.id;

                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          color: isSelected
                              ? Colors.blue.shade50
                              : Colors.white,
                          elevation: isSelected ? 4 : 1,
                          child: ListTile(
                            onTap: () {
                              setState(
                                () => selectedReceipt = receipt,
                              ); //ไม่ได้ค่อยกลับมาแก้ เติม id
                              widget.onSelect(receipt);
                            },
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                '${receipt.id}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              receipt.receiptNo,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            subtitle: Text(
                              '${_formatDate(receipt.createdAt)} • ${receipt.totalAmount} items',
                            ),

                            trailing: Text(
                              '฿${receipt.totalSummary.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';

    final local = date
        .toLocal(); // ตัวนี้แหละกำหนดlocal timezoneจากเครื่องผู้ใช้

    return '${local.day}/${local.month}/${local.year}\n'
        '${local.hour.toString().padLeft(2, '0')}:'
        '${local.minute.toString().padLeft(2, '0')}';
  }
}
