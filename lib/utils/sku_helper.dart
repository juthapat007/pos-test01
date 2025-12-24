import '../models/sku_master.dart';

class SkuHelper {
  static String getSkuName({
    required int skuId,
    required List<SkuMaster> skus,
  }) {
    try {
      return skus.firstWhere((s) => s.id == skuId).name;
    } catch (e) {
      return 'Unknown SKU';
    }
  }
}
