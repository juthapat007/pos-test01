import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/sku_master.dart';
import 'package:flutter_application_2/screens/widgets/common_widgets.dart';
import 'product_card.dart';

class ProductPanelWidget extends StatefulWidget {
  final List<SkuMaster> products;
  final bool isLoading;
  final Function(SkuMaster) onProductTap;
  final Function(String keyword) onSearch;

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
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  // 🎯 คำนวณจำนวนคอลัมน์ตามความกว้าง
  int _getCrossAxisCount(double width) {
    if (width < 600) return 2; // Mobile
    if (width < 900) return 3; // Tablet
    if (width < 1200) return 4; // Desktop เล็ก
    if (width < 1500) return 5; // Desktop กลาง
    return 6; // Desktop ใหญ่ - เพิ่มคอลัมน์เพื่อไม่ให้โล่ง
  }

  // 🎯 คำนวณ childAspectRatio ตามความกว้าง (ยิ่งมากยิ่งแบน)
  double _getChildAspectRatio(double width) {
    if (width < 600) return 1.0; // Mobile: สี่เหลี่ยมจัตุรัส
    if (width < 900) return 1.2; // Tablet: แบนขึ้น
    if (width < 1200) return 1.3; // Desktop เล็ก: แบนขึ้นอีก
    return 1.4; // Desktop ใหญ่: แบนสุด
  }

  // 🎯 คำนวณ spacing ตามความกว้าง
  double _getSpacing(double width) {
    if (width < 600) return 8.0;
    if (width < 900) return 12.0;
    if (width < 1200) return 14.0;
    return 16.0; // Desktop ใหญ่: spacing เพิ่มขึ้นเล็กน้อย
  }

  // 🎯 คำนวณ padding ตามความกว้าง
  double _getPadding(double width) {
    if (width < 600) return 8.0;
    if (width < 900) return 12.0;
    if (width < 1200) return 16.0;
    return 20.0; // Desktop ใหญ่: padding เพิ่มขึ้น
  }

  // 🎯 คำนวณขนาดตัวอักษรหัวข้อ
  double _getTitleFontSize(double width) {
    if (width < 600) return 18.0;
    if (width < 900) return 20.0;
    if (width < 1200) return 22.0;
    return 24.0;
  }

  // 🎯 จำกัดความกว้างสูงสุดของ container
  double _getMaxWidth(double screenWidth) {
    if (screenWidth < 600) return screenWidth; // Mobile: เต็มจอ
    if (screenWidth < 900) return screenWidth; // Tablet: เต็มจอ
    if (screenWidth < 1400) return screenWidth; // Desktop เล็ก: เต็มจอ
    return screenWidth * 0.9; // Desktop ใหญ่: จำกัด 90%
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      flex: 5,
      child: Center(
        // 🎯 Center เพื่อให้ container อยู่กลาง
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: _getMaxWidth(screenWidth), // 🎯 จำกัดความกว้างสูงสุด
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final crossAxisCount = _getCrossAxisCount(width);
              final childAspectRatio = _getChildAspectRatio(width);
              final spacing = _getSpacing(width);
              final padding = _getPadding(width);
              final titleFontSize = _getTitleFontSize(width);

              return Container(
                padding: EdgeInsets.all(padding),
                decoration: CommonWidgets.boxStyle(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row - ใส่ icon หรือ filter ได้
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Products',
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // จำนวนสินค้า
                        if (!widget.isLoading)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${widget.products.length} รายการ',
                              style: TextStyle(
                                fontSize: titleFontSize * 0.6,
                                color: Colors.blue[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),

                    SizedBox(height: spacing),

                    // Search Field - ปรับความกว้าง
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: width < 900 ? double.infinity : 400,
                      ),
                      child: TextField(
                        maxLength: 20,
                        decoration: const InputDecoration(
                          counterText: "",
                          labelText: "ค้นหา",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        onChanged: _onSearchChanged,
                      ),
                    ),

                    SizedBox(height: spacing),

                    // Product Grid
                    Expanded(
                      child: widget.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : widget.products.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.inventory_2_outlined,
                                    size: titleFontSize * 3,
                                    color: Colors.grey[300],
                                  ),
                                  SizedBox(height: spacing),
                                  Text(
                                    'ไม่พบสินค้า',
                                    style: TextStyle(
                                      fontSize: titleFontSize * 0.7,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: spacing,
                                    mainAxisSpacing: spacing,
                                    childAspectRatio: childAspectRatio,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
