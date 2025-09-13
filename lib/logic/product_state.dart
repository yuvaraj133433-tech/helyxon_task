import 'package:equatable/equatable.dart';
import 'package:helyxon_1/data/modeles/product_model.dart' show Product;


abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Product> filtered;

  ProductLoaded({required this.products, required this.filtered});

  @override
  List<Object?> get props => [products, filtered];
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
