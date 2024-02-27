import 'package:e_commerce/business_logic/blocs/wishlist/wishlist_bloc.dart';
import 'package:e_commerce/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/theme.dart';

class WishListItemCard extends StatelessWidget {
  final ProductModel product;

  const WishListItemCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            image: DecorationImage(
                image: NetworkImage(product.imageUrl), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          bottom: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            height: 70,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: const BoxDecoration(
              color: Colors.black45,
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            height: 50,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      product.name,
                      style: theme()
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      product.price.toString(),
                      style: theme()
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle, color: Colors.white),
                ),
                BlocBuilder<WishlistBloc, WishlistState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        // Remove Product from WishList
                        context
                            .read<WishlistBloc>()
                            .add(RemoveWishlistProduct(product));
                        const snackBar = SnackBar(
                          content: Text("Product Removed from WishList"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      icon: const Icon(Icons.delete, color: Colors.white),
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
