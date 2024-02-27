import 'package:e_commerce/business_logic/blocs/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/strings.dart';
import '../../data/models/models.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final double widthFactor;

  const ProductCard({
    super.key,
    required this.product,
    this.widthFactor = 2.5,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, productScreen, arguments: product);
      },
      child: Stack(
        children: [
          // Container hold the Image
          SizedBox(
            width: MediaQuery.of(context).size.width / widthFactor,
            height: 170,
            child: Image.network(product.imageUrl, fit: BoxFit.cover),
          ),
          // Container hold the information
          Positioned(
            bottom: 8,
            child: Container(
              width: MediaQuery.of(context).size.width / widthFactor,
              height: 50,
              color: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    Expanded(
                      // use flex to always mantain the width of the widget
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            "\$${product.price.toString()}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartLoading) {
                          return const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator());
                        } else if (state is CartLoaded) {
                          return Expanded(
                            child: IconButton(
                              // Add Product to Cart
                              onPressed: () {
                                context.read<CartBloc>().add(
                                      AddCartProduct(product),
                                    );
                              },
                              icon: const Icon(Icons.add_circle,
                                  color: Colors.white),
                            ),
                          );
                        } else {
                          return const Text("Something went wrong");
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
