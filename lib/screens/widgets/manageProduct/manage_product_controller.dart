import 'dart:ui';

import 'package:flutter_application_2/models/sku_master.dart';

class ManageProductController {
  final VoidCallback onAdd;
  final Function(SkuMaster) onEdit;
  final Function(SkuMaster) onDelete;
  final VoidCallback onRefresh;

  ManageProductController({
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
    required this.onRefresh,
  });
}
