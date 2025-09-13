import 'package:helyxon_1/data/modeles/product_model.dart' show Product;
import 'package:hive/hive.dart';

class HiveService {
  static const String productBox = "productsBox";

  /// Save list of products to Hive
  Future<void> saveProducts(List<Product> products) async {
    var box = await Hive.openBox(productBox);

    // Convert each product to JSON before saving
    final List<Map<String, dynamic>> jsonList =
        products.map((e) => e.toJson()).toList();

    await box.put("cached_products", jsonList);
  }

  /// Load cached products from Hive
  Future<List<Product>> getCachedProducts() async {
    var box = await Hive.openBox(productBox);
    final cached = box.get("cached_products");

    if (cached != null) {
      return (cached as List)
          .map((e) => Product.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }

    return [];
  }
}
