import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helyxon_1/data/repositories/product_repositories.dart'
    show ProductRepository;
import 'package:helyxon_1/logic/product_bloc.dart' show ProductBloc;
import 'package:helyxon_1/logic/product_event.dart' show SearchProducts;

import 'package:helyxon_1/logic/product_state.dart'
    show ProductState, ProductLoading, ProductLoaded, ProductError;
import 'package:helyxon_1/presentation/product_details_screen.dart'
    show ProductDetailScreen;
import 'package:helyxon_1/presentation/widgets/filter_dropdown.dart'
    show FilterDropdown;
import 'package:helyxon_1/presentation/widgets/popum_menu.dart' show PopuMenu;
import 'package:helyxon_1/presentation/widgets/product_widgets.dart'
    show ProductCard;
import 'package:helyxon_1/theme/theme_cubit.dart' show ThemeCubit;

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String? selectedCategory;
  String? sortOption;
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() async {
    final repo = ProductRepository();
    final fetched = await repo.getCategories();
    setState(() {
      categories = fetched;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) =>
                  context.read<ProductBloc>().add(SearchProducts(value)),
              decoration: const InputDecoration(
                hintText: "Search products...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: const Text("Fake Store"),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<ThemeCubit, ThemeData>(
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
          ),
        ],leading: PopuMenu(),
      ),
      
      body: Column(
        children: [
          FilterDropdown(),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailScreen(product: product),
                          ),
                        ),
                        child: ProductCard(product: product),
                      );
                    },
                  );
                } else if (state is ProductError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text("No Products Found"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
