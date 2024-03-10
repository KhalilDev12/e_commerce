import 'package:e_commerce/business_logic/blocs/wishlist/wishlist_bloc.dart';
import 'package:e_commerce/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/theme.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Wishlist"),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WishlistLoaded) {
            if (state.wishlist.isNotEmpty) {
              return GridView.builder(
                itemCount: state.wishlist.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 2.1,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return WishListItemCard(
                    product: state.wishlist[index],
                  );
                },
              );
            } else {
              return Center(
                  child: Text(
                "Your Wishlist is EMPTY  !! ",
                style: theme().textTheme.displaySmall,
              ));
            }
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }
}
