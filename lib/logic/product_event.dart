import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProducts extends ProductEvent {}

class FetchProductsByCategory extends ProductEvent {
  final String category;
  FetchProductsByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class SortProducts extends ProductEvent {
  final String option; // e.g. "Price: Low to High"
  SortProducts(this.option);

  @override
  List<Object?> get props => [option];
}
class SearchProducts extends ProductEvent {
  final String query;
  SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}
