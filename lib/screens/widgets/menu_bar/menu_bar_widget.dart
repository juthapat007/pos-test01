import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/product_item.dart';
import 'menu_button.dart'; // ✅ import จากไฟล์ที่แยกแล้ว

/// MenuBar สำหรับเลือกหน้าต่างๆ
class MenuBarWidget extends StatelessWidget {
  final MenuPage currentPage;
  final Function(MenuPage) onMenuChanged;
  final VoidCallback onLogout;

  const MenuBarWidget({
    super.key,
    required this.currentPage,
    required this.onMenuChanged,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MenuButton(
              // ✅ ใช้จากไฟล์ menu_button.dart
              'Menu',
              icon: Icons.dashboard,
              onPressed: () => onMenuChanged(MenuPage.products),
            ),
            MenuButton(
              'Manage products',
              icon: Icons.inventory,
              onPressed: () => onMenuChanged(MenuPage.manageProducts),
            ),
            MenuButton(
              'List receipt',
              icon: Icons.receipt_long,
              onPressed: () => onMenuChanged(MenuPage.orders),
            ),
            const Spacer(),
            MenuButton(
              'Logout',
              isDanger: true,
              onPressed: () {
                print('LOGOUT CLICKED');
                onLogout();
              },

              icon: Icons.logout,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
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

// ⚠️ ห้ามมี class _MenuButton อยู่ด้านล่างนี้!
