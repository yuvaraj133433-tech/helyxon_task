import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helyxon_1/data/repositories/product_repositories.dart'
    show ProductRepository;
import 'package:helyxon_1/logic/product_bloc.dart' show ProductBloc;
import 'package:helyxon_1/logic/product_event.dart' show FetchProducts;
import 'package:helyxon_1/presentation/peoduct_list_screen.dart'
    show ProductListScreen;
import 'package:hive_flutter/hive_flutter.dart';
import 'theme/theme_cubit.dart';

// void main() {
//   final repository = ProductRepository();
//   runApp(MyApp(repository: repository));
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('products');
  await Hive.openBox('categories');
  await Hive.openBox('settings');
  final repository = ProductRepository();
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final ProductRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(
          create: (_) =>
              ProductBloc(repository: repository)..add(FetchProducts()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fake Store',
            theme: theme,
            home: ProductListScreen(),
          );
        },
      ),
    );
  }
}
