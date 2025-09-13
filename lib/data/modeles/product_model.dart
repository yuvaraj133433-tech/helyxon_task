class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rate;
  final int count;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
    required this.count,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      price: (map['price'] is int)
          ? (map['price'] as int).toDouble()
          : (map['price'] as num).toDouble(),
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      image: map['image'] ?? '',
      rate: map['rating'] != null
          ? (map['rating']['rate'] as num).toDouble()
          : 0.0,
      count: map['rating'] != null
          ? (map['rating']['count'] as num).toInt()
          : 0,
    );
  }

  /// Convert Product -> JSON map
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "description": description,
      "category": category,
      "image": image,
      "rating": {
        "rate": rate,
        "count": count,
      }
    };
  }

  /// Convert JSON map -> Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product.fromMap(json);
  }
}
