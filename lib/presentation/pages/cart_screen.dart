import 'package:e_commerce/business_logic/blocs/cart/cart_bloc.dart';
import 'package:e_commerce/constants/strings.dart';
import 'package:e_commerce/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/theme.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Cart"),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CartLoaded) {
          if (state.cart.cartProducts.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.cart.freeDeliveryMessage(),
                          style: theme().textTheme.bodyLarge,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: const RoundedRectangleBorder(),
                              elevation: 0),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushReplacementNamed(mainScreen);
                          },
                          child: Text(
                            "Add More items",
                            style: theme()
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        itemCount: state.cart.cartProducts.length,
                        itemBuilder: (context, index) {
                          final product = state.cart.cartProducts[index];
                          return CartProductCard(
                            onIncreaseQuantity: () => context
                                .read<CartBloc>()
                                .add(AddCartProduct(product)),
                            onDecreaseQuantity: () => context
                                .read<CartBloc>()
                                .add(RemoveCartProduct(product)),
                            onCheckProduct: (p0) => context
                                .read<CartBloc>()
                                .add(CheckProduct(product)),
                            cartProduct: product,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                OrderSumarryWidget(),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }

  BottomAppBar _buildBottomNavigationBar(BuildContext parentContext) {
    return BottomAppBar(
      height: 60,
      color: Colors.black,
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                        value: state.cart.cartProducts.isNotEmpty &&
                            state.cart.cartProducts.every((p) => p.isSelected),
                        onChanged: (value) => context
                            .read<CartBloc>()
                            .add(CheckAllProduct(value!))),
                    Text("All",
                        style: theme()
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.white)),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: Colors.white),
                  onPressed: () {
                    if (state.cart.selectedCartProducts().isNotEmpty) {
                      Navigator.of(parentContext, rootNavigator: true)
                          .pushNamed(checkoutScreen);
                    }
                  },
                  child: Text(
                    "GO TO CHECKOUT",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                )
              ],
            );
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}
