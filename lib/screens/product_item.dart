import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/category.dart';
import 'package:flutter_application_2/models/sku_master.dart';
import 'package:flutter_application_2/screens/widgets/receipt_detail_panel_widget.dart';
import 'package:flutter_application_2/services/sku_service.dart';
import 'package:flutter_application_2/models/cartitem.dart';
import 'package:flutter_application_2/services/category_service.dart';
import 'widgets/menu_bar/menu_bar_widget.dart';
import 'widgets/menu_bar/menu_button.dart';
import 'widgets/product_panel_widget.dart';
import 'widgets/manage_product_panel_widget.dart';
import 'widgets/manage_side_panel_widget.dart';
import 'widgets/order_panel_widget.dart';
import 'widgets/receipt_detail_panel_widget.dart';

enum MenuPage { products, manageProducts, orders }

enum ManageMode { none, add, edit }

class ProductItem extends StatefulWidget {
  final String token;

  const ProductItem({super.key, required this.token});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  MenuPage currentPage = MenuPage.products;
  ManageMode manageMode = ManageMode.none;
  SkuMaster? selectedProduct;
  List<SkuMaster> products = [];
  List<CartItem> cart = [];
  List<Category> categories = [];
  Category? selectedCategory;
  bool isLoading = true;
  bool isSaving = false;
  bool isDeleting = false;
  int? selectedReceiptId;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  void onReceiptSelected(int receiptId) {
    setState(() {
      selectedReceiptId = receiptId;
    });

    print('เลือกใบเสร็จ ID: $receiptId');
  }

  void onMenuChanged(MenuPage page) {
    setState(() {
      currentPage = page;
    });
  }

  double get totalPrice {
    return cart.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
    loadCategories();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void addToCart(SkuMaster product) {
    setState(() {
      final index = cart.indexWhere((item) => item.product.id == product.id);
      if (index >= 0) {
        cart[index].quantity++;
      } else {
        cart.add(CartItem(product: product));
      }
    });
  }

  Future<void> loadCategories() async {
    final data = await CategoryService.fetchCategories(widget.token);
    setState(() => categories = data);
  }

  Future<void> loadProducts() async {
    try {
      final data = await SkuService.fetchSkuMasters(widget.token);
      setState(() {
        products = data;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() => isLoading = false);
    }
  }

  Future<void> createProduct() async {
    if (selectedCategory == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a category')));
      return;
    }

    if (nameController.text.isEmpty || priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    setState(() => isSaving = true);

    try {
      final newProduct = await SkuService.createSkuMaster(
        widget.token,
        name: nameController.text,
        price: double.parse(priceController.text),
        categoryId: selectedCategory!.id,
      );

      setState(() {
        products.add(newProduct);
        manageMode = ManageMode.none;
        nameController.clear();
        priceController.clear();
        selectedCategory = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product created successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Creation failed')));
    } finally {
      setState(() => isSaving = false);
    }
  }

  Future<void> updateProduct() async {
    if (selectedProduct == null || selectedCategory == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a category')));
      return;
    }

    setState(() => isSaving = true);

    try {
      final updatedProduct = await SkuService.updateSkuMaster(
        widget.token,
        selectedProduct!.id,
        name: nameController.text,
        price: double.parse(priceController.text),
        categoryId: selectedCategory!.id,
      );

      setState(() {
        final index = products.indexWhere((p) => p.id == updatedProduct.id);
        if (index != -1) {
          products[index] = updatedProduct;
        }

        manageMode = ManageMode.none;
        selectedProduct = null;
        selectedCategory = null;
        nameController.clear();
        priceController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Update failed')));
    } finally {
      setState(() => isSaving = false);
    }
  }

  Future<void> confirmDeleteProduct(SkuMaster product) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await deleteProduct(product);
    }
  }

  Future<void> deleteProduct(SkuMaster product) async {
    if (isDeleting) return;

    setState(() => isDeleting = true);

    try {
      await SkuService.deleteSkuMaster(widget.token, product.id);

      setState(() {
        products.removeWhere((p) => p.id == product.id);
        manageMode = ManageMode.none;
        selectedProduct = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to delete product')));
    } finally {
      setState(() => isDeleting = false);
    }
  }

  // void onMenuChanged(MenuPage page) {
  //   setState(() {
  //     currentPage = page;
  //   });
  // }

  void onAddProductPressed() {
    setState(() {
      manageMode = ManageMode.add;
      selectedProduct = null;
      selectedCategory = null;
      nameController.clear();
      priceController.clear();
    });
  }

  void onEditProductPressed(SkuMaster product) {
    setState(() {
      manageMode = ManageMode.edit;
      selectedProduct = product;
      nameController.text = product.name;
      priceController.text = product.price.toString();
      selectedCategory = categories.firstWhere(
        (c) => c.id == product.categoryId,
      );
    });
  }

  void onCategoryChanged(Category? category) {
    setState(() {
      selectedCategory = category;
    });
  }

  //เอาไว้แบ่งPanel หน้า
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(title: const Text('POS / Products')),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  MenuBarWidget(
                    currentPage: currentPage,
                    onMenuChanged: onMenuChanged,
                  ),
                  const SizedBox(width: 12),
                  _buildCenterPanel(),
                  const SizedBox(width: 12),
                  _buildRightPanel(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterPanel() {
    switch (currentPage) {
      case MenuPage.manageProducts:
        return ManageProductPanelWidget(
          products: products,
          onAddPressed: onAddProductPressed,
          onEditPressed: onEditProductPressed,
          onDeletePressed: confirmDeleteProduct,
          onRefresh: loadProducts,
        );
      // case MenuPage.orders:
      //   // แก้ตรงนี้
      //   return OrderListPanelWidget(
      //     token: widget.token,
      //     onSelect: onReceiptSelected,
      //   );

      case MenuPage.products:
      default:
        return ProductPanelWidget(
          products: products,
          isLoading: isLoading,
          onProductTap: addToCart,
        );
    }
  }

  void clearCart() {
    setState(() {
      cart.clear();
    });
  }

  void processPayment() {
    if (cart.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Cart is empty')));
      return;
    }

    // TODO: เพิ่ม logic สำหรับการชำระเงินจริง
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment processed: ฿${totalPrice.toStringAsFixed(2)}'),
      ),
    );

    // เคลียร์ตะกร้าหลังชำระเงิน
    clearCart();
  }

  Widget _buildRightPanel() {
    if (currentPage == MenuPage.manageProducts) {
      return ManageSidePanelWidget(
        manageMode: manageMode,
        nameController: nameController,
        priceController: priceController,
        categories: categories,
        selectedCategory: selectedCategory,
        selectedProduct: selectedProduct,
        isSaving: isSaving,
        onCategoryChanged: onCategoryChanged,
        onCreateProduct: createProduct,
        onUpdateProduct: updateProduct,
      );
    }

    if (currentPage == MenuPage.orders) {
      if (selectedReceiptId != null) {
        return ReceiptDetailPanelWidget(
          receiptId: selectedReceiptId!,
          token: widget.token,
        );
      } else {
        // ยังไม่ได้เลือกใบเสร็จ
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
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Select a receipt to view details',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    // Default: แสดง cart (สำหรับหน้า products)
    return OrderPanelWidget(
      cart: cart,
      totalPrice: totalPrice,
      onCancel: clearCart,
      onPay: processPayment,
    );
  }
}
