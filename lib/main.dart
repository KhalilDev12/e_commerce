import 'package:e_commerce/business_logic/blocs/cart/cart_bloc.dart';
import 'package:e_commerce/business_logic/blocs/category/category_bloc.dart';
import 'package:e_commerce/business_logic/blocs/product/product_bloc.dart';
import 'package:e_commerce/business_logic/blocs/wishlist/wishlist_bloc.dart';
import 'package:e_commerce/config/app_router.dart';
import 'package:e_commerce/config/theme.dart';
import 'package:e_commerce/data/repositories/category_repository.dart';
import 'package:e_commerce/data/repositories/product_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WishlistBloc()..add(StartWishlist()),
        ),
        BlocProvider(
          create: (context) => CartBloc()..add(StartCart()),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
            categoryRepository: CategoryRepository(),
          )..add(LoadCategories()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(
            productRepository: ProductRepository(),
          )..add(LoadProducts()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        title: 'Flutter Demo',
        onGenerateRoute: AppRouter().onGenerateRoute,
      ),
    );
  }
}
