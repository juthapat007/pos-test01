import 'package:flutter/material.dart';

// รวม style ที่ใช้ซ้ำ
// ทำ UI ให้หน้าตาเหมือนกันทั้งแอป
class CommonWidgets {
  static BoxDecoration boxStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
