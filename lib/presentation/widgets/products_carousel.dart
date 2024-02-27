import 'package:flutter/material.dart';

import '../../data/models/models.dart';
import 'widgets.dart';

class ProductsCarousel extends StatelessWidget {
  final List<ProductModel> products;

  const ProductsCarousel({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ProductCard(product: products[index]),
          );
        },
      ),
    );
  }
}
