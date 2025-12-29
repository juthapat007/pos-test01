import 'package:flutter/material.dart';
import 'package:flutter_application_2/config/cons.dart';

// ปุ่มเมนูที่ใช้ใน MenuBar
// แยกออกมาเป็นไฟล์เดี่ยวเพื่อให้จัดการง่ายและลด rebuild
class MenuButton extends StatelessWidget {
  final String text;
  final bool isDanger;
  final VoidCallback? onPressed;
  final IconData? icon;

  const MenuButton(
    this.text, {
    super.key,
    this.isDanger = false,
    this.onPressed,
    this.icon,
    // required Text child,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDanger
        ? Colors.red.withValues(alpha: 0.1)
        : Colors.grey.shade100;
    final textColor = isDanger ? Colors.red.shade700 : Colors.black87;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: _buildButtonContent(textColor),
            ),
          ),
        ),
      ),
    );
  }

  // สร้าง content ข้างในปุ่ม (icon + text)
  Widget _buildButtonContent(Color textColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20, color: textColor),
          const SizedBox(width: TextSpacing.md),
        ],
        Flexible(
          child: Text(
            text,
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: TextSpacing.sm,
              fontWeight: isDanger ? FontWeight.bold : FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}
