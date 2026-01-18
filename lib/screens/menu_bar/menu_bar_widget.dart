import 'package:flutter/material.dart';
import 'package:flutter_application_2/enums/btn_variant.dart';
import 'package:flutter_application_2/screens/product_item.dart';
import 'package:flutter_application_2/theme/app_decorations.dart';
import 'menu_button.dart';

// MenuBar สำหรับเลือกหน้า
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
        // margin: const EdgeInsets.all(12),
        decoration: AppDecorations.sidebar(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppButton(
              text: 'Menu',
              icon: Icons.dashboard,
              onPressed: () => onMenuChanged(MenuPage.products),
            ),

            AppButton(
              text: 'Manage products',
              icon: Icons.inventory,
              onPressed: () => onMenuChanged(MenuPage.manageProducts),
            ),

            AppButton(
              text: 'List receipt',

              icon: Icons.receipt_long,
              onPressed: () => onMenuChanged(MenuPage.orders),
            ),

            const Spacer(),

            AppButton(
              text: 'Logout',
              variant: BtnVariant.danger,
              icon: Icons.logout,
              onPressed: () {
                print('LOGOUT CLICKED');
                onLogout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
