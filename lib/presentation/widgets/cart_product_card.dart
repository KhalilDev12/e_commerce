import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/cart/cart_bloc.dart';
import '../../config/theme.dart';
import '../../data/models/models.dart';

class CartProductCard extends StatelessWidget {
  final ProductCartModel cartProduct;
  final VoidCallback onIncreaseQuantity;
  final VoidCallback onDecreaseQuantity;
  final void Function(bool?)? onCheckProduct;

  CartProductCard(
      {Key? key,
      required this.cartProduct,
      required this.onIncreaseQuantity,
      required this.onDecreaseQuantity,
      required this.onCheckProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: cartProduct.isSelected,
            onChanged: onCheckProduct,
          ),
          Image.network(
            cartProduct.product.imageUrl,
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
                  cartProduct.product.name,
                  style: theme().textTheme.displaySmall,
                ),
                Text(
                  "\$${cartProduct.product.price}",
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
                      onPressed: onDecreaseQuantity,
                      icon: const Icon(Icons.remove_circle)),
                  Text("${cartProduct.quantity}",
                      style: theme().textTheme.displaySmall),
                  IconButton(
                      onPressed: onIncreaseQuantity,
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
