// lib/data/filter_options.dart

/// All product categories (static for now, can be replaced with API later)
final List<String> categories = [
  "electronics",
  "jewelery",
  "men's clothing",
  "women's clothing",
];

/// Sorting options
final List<String> sortOptions = [
  "Price: Low to High",
  "Price: High to Low",
];
 List<String> get allFilters => [
        "All Products",
        ...categories.map((c) => "Category: $c"),
        ...sortOptions,
      ];