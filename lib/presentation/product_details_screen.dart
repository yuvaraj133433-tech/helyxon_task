import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:helyxon_1/data/modeles/product_model.dart' show Product;
import 'package:helyxon_1/theme/theme_cubit.dart' show ThemeCubit;

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.product.title),
        actions: [
          BlocBuilder<ThemeCubit, ThemeData>(
            builder: (context, theme) {
              final isDark = theme.brightness == Brightness.dark;
              return Row(
                children: [
                  Text(
                    isDark ? "Dark" : "Light",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Switch.adaptive(
                    value: isDark,
                    onChanged: (_) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.product.image, height: 250),
            const SizedBox(height: 10),
            Text(
              widget.product.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "\$${widget.product.price}",
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 10),
            Text(
              "Category: ${widget.product.category}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "Rating: ${widget.product.rate} ⭐(${widget.product.count} reviews)",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(widget.product.description, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
