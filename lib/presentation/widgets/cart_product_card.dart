import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/cart/cart_bloc.dart';
import '../../config/theme.dart';
import '../../data/models/models.dart';

class CartProductCard extends StatelessWidget {
  final ProductModel product;
  final int quantity;

  CartProductCard({Key? key, required this.product, required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: false,
            onChanged: (value) {
            },
          ),
          Image.network(
            product.imageUrl,
            height: 80,
            width: 80,
            fit: BoxFit.fill,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: theme().textTheme.displaySmall,
                ),
                Text(
                  "\$${product.price}",
                  style: theme().textTheme.bodyLarge,
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                      onPressed: () {
                        context
                            .read<CartBloc>()
                            .add(RemoveCartProduct(product));
                      },
                      icon: const Icon(Icons.remove_circle)),
                  Text("$quantity", style: theme().textTheme.displaySmall),
                  IconButton(
                      onPressed: () {
                        context
                            .read<CartBloc>()
                            .add(AddCartProduct(product));
                      },
                      icon: const Icon(Icons.add_circle)),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
