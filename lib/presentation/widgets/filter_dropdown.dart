import 'package:flutter/material.dart'
    show
        StatefulWidget,
        State,
        BuildContext,
        Widget,
        SizedBox,
        Text,
        Icon,
        Icons,
        DropdownMenuItem,
        DropdownButton;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helyxon_1/data/modeles/filter_option.dart' show allFilters;
import 'package:helyxon_1/logic/product_bloc.dart' show ProductBloc;
import 'package:helyxon_1/logic/product_event.dart' show FetchProducts, FetchProductsByCategory, SortProducts;

class FilterDropdown extends StatefulWidget {
  const FilterDropdown({super.key});

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  String? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: const SizedBox(),
      value: selectedFilter,
      hint: const Text("Filter"),
      // 👇 replace default arrow with filter icon
      icon: const Icon(Icons.filter_list),
      items: allFilters.map((filter) {
        return DropdownMenuItem(value: filter, child: Text(filter));
      }).toList(),
      onChanged: (value) {
        setState(() => selectedFilter = value);

        if (value == "All Products") {
          context.read<ProductBloc>().add(FetchProducts());
        } else if (value!.startsWith("Category: ")) {
          final category = value.replaceFirst("Category: ", "");
          context.read<ProductBloc>().add(FetchProductsByCategory(category));
        } else {
          context.read<ProductBloc>().add(SortProducts(value));
        }
      },
    );
  }
}
