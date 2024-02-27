import 'package:e_commerce/data/models/models.dart';
import 'package:e_commerce/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/product/product_bloc.dart';

class CatalogScreen extends StatelessWidget {
  final CategoryModel category;

  const CatalogScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: category.name),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            // get products belongs to a specific category;
            final List<ProductModel> categoryList = state.products
                .where((product) => product.category == category.name)
                .toList();
            return GridView.builder(
              itemCount: categoryList.length,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.15,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Center(
                  child: ProductCard(product: categoryList[index]),
                );
              },
            );
          } else {
            return const Center(child: Text("Something happend"));
          }
        },
      ),
    );
  }
}
