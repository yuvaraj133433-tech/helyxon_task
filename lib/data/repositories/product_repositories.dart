import 'dart:convert';
import 'package:helyxon_1/data/modeles/product_model.dart' show Product;
import 'package:http/http.dart' as http;

class ProductRepository {
  final String baseUrl = "https://fakestoreapi.com/products";

  /// Get all products
  Future<List<Product>> getAllProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data
          .map((e) => Product.fromMap(Map<String, dynamic>.from(e)))
          .toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  /// Get categories
  Future<List<String>> getCategories() async {
    final response = await http.get(Uri.parse("$baseUrl/categories"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => e.toString()).toList();
    } else {
      throw Exception("Failed to load categories");
    }
  }

  /// Get products by category
  Future<List<Product>> getProductsByCategory(String category) async {
    final response = await http.get(Uri.parse("$baseUrl/category/$category"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data
          .map((e) => Product.fromMap(Map<String, dynamic>.from(e)))
          .toList();
    } else {
      throw Exception("Failed to load products by category");
    }
  }
}
