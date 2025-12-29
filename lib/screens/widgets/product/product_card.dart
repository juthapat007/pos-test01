import 'package:flutter/material.dart';
import 'package:flutter_application_2/config/cons.dart';
import 'package:flutter_application_2/models/sku_master.dart';
import 'package:flutter_application_2/screens/widgets/common_widgets.dart';

class ProductCard extends StatelessWidget {
  final SkuMaster product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  double _getFontSize(double width, {bool isTitle = false}) {
    if (isTitle) {
      if (width < 100) return 12;
      if (width < 150) return 14;
      return 16;
    }
    if (width < 100) return 11;
    if (width < 150) return 13;
    return 14;
  }

  double _getPadding(double width) {
    if (width < 100) return 6;
    if (width < 150) return 8;
    return 10;
  }

  double _getButtonHeight(double width) {
    if (width < 100) return 28;
    if (width < 150) return 32;
    return 36;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final padding = _getPadding(width);
        final titleFontSize = _getFontSize(width, isTitle: true);
        final priceFontSize = _getFontSize(width);
        final buttonHeight = _getButtonHeight(width);

        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(padding),
            decoration: CommonWidgets.boxStyle(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: titleFontSize,
                  ),
                ),

                const SizedBox(height: HeightSpacing.hm),

                Text(
                  '฿${product.price}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: priceFontSize,
                    color: Colors.green[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const Spacer(),

                // 🔒 ปุ่มสูงคงที่
                SizedBox(
                  height: buttonHeight,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: padding * 0.5),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'เลือก',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: priceFontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
