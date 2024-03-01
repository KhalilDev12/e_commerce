
import 'package:e_commerce/presentation/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/constants/strings.dart';

import '../data/models/models.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    print("This is route : ${settings.name}");

    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case cartScreen:
        return MaterialPageRoute(
          builder: (context) => CartScreen(),
        );
      case userScreen:
        return MaterialPageRoute(
          builder: (context) => UserScreen(),
        );
      case catalogScreen:
        return MaterialPageRoute(
          builder: (context) =>
              CatalogScreen(category: settings.arguments as CategoryModel),
        );
      case productScreen:
        return MaterialPageRoute(
          builder: (context) =>
              ProductScreen(product: settings.arguments as ProductModel),
        );
      case wishlistScreen:
        return MaterialPageRoute(
          builder: (context) => WishlistScreen(),
        );
      case checkoutScreen:
        return MaterialPageRoute(
          builder: (context) => CheckoutScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
      ),
    );
  }
}
