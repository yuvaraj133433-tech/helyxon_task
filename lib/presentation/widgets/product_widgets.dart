import 'package:flutter/material.dart';
import 'package:helyxon_1/data/modeles/product_model.dart' show Product;



class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: Image.network(product.image, fit: BoxFit.contain),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          Text("\$${product.price}", style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}



