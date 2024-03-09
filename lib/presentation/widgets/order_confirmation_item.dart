import 'package:e_commerce/data/models/models.dart';
import 'package:flutter/material.dart';

import '../../config/theme.dart';

class OrderConfirmationItem extends StatelessWidget {
  final ProductCartModel cartProduct;

  const OrderConfirmationItem({
    super.key,
    required this.cartProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.network(cartProduct.product.imageUrl,
              fit: BoxFit.fill, height: 80, width: 80),
          const SizedBox(width: 5),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cartProduct.product.name,
                    style: theme().textTheme.displaySmall),
                Text(
                  "Quantity: ${cartProduct.quantity}",
                  style: theme().textTheme.bodyLarge,
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("\$${cartProduct.product.price * cartProduct.quantity}",
                    style: theme().textTheme.displaySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
