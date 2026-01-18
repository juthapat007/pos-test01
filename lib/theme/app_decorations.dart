import 'package:flutter/material.dart';

class AppDecorations {
  static BoxDecoration sidebar() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2), // ปลอดภัยกว่า
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
