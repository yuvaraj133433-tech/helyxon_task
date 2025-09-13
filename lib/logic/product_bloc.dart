import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helyxon_1/data/modeles/product_model.dart';
import 'package:helyxon_1/data/repositories/product_repositories.dart'
    show ProductRepository;
import 'package:helyxon_1/services/hive_services.dart' show HiveService;
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;
  final HiveService hiveService = HiveService();

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    // Fetch all products (with caching)
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final cachedProducts = await hiveService.getCachedProducts();
        if (cachedProducts.isNotEmpty) {
          emit(
            ProductLoaded(products: cachedProducts, filtered: cachedProducts),
          );
        }
        final products = await repository.getAllProducts();
        await hiveService.saveProducts(products);
        emit(ProductLoaded(products: products, filtered: products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Fetch products by category
    on<FetchProductsByCategory>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await repository.getProductsByCategory(event.category);
        emit(ProductLoaded(products: products, filtered: products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Sort products
    on<SortProducts>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        final products = List<Product>.from(currentState.products); // full list
        if (event.option == "Price: Low to High") {
          products.sort((a, b) => a.price.compareTo(b.price));
        } else if (event.option == "Price: High to Low") {
          products.sort((a, b) => b.price.compareTo(a.price));
        }
        // Update both full and filtered lists after sorting
        emit(ProductLoaded(products: products, filtered: products));
      }
    });

    // Search products handler
    on<SearchProducts>(_onSearchProducts);
  }

void _onSearchProducts(
      SearchProducts event, Emitter<ProductState> emit) {
    if (state is ProductLoaded) {
      final loaded = state as ProductLoaded;
      final filtered = loaded.products
          .where((p) => p.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(ProductLoaded(products: loaded.products, filtered: filtered));
    }
  }
  }

