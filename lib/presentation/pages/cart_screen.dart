import 'package:e_commerce/business_logic/blocs/cart/cart_bloc.dart';
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
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
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
                            onPressed: () {},
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
                        height: 250,
                        child: ListView.builder(
                          itemCount: state.cart
                              .productQuantity(state.cart.cartProducts)
                              .keys
                              .length,
                          itemBuilder: (context, index) {
                            return CartProductCard(
                              product: state.cart.productQuantity(state.cart.cartProducts).keys.elementAt(
                                  index),
                              quantity:state.cart.productQuantity(state.cart.cartProducts).values.elementAt(
                                  index));
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Divider(thickness: 2),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "SUBTOTAL",
                                  style: theme().textTheme.displaySmall,
                                ),
                                Text(
                                  "\$${state.cart.subTotalString}",
                                  style: theme().textTheme.displaySmall,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "DELIVERY FEE",
                                  style: theme().textTheme.displaySmall,
                                ),
                                Text(
                                  "\$${state.cart.deliveryFeeString}",
                                  style: theme().textTheme.displaySmall,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: 60,
                            color: Colors.grey,
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: 50,
                            margin: const EdgeInsets.all(5),
                            color: Colors.black,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "TOTAL",
                                    style: theme()
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    "\$${state.cart.totalString}",
                                    style: theme()
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }

  BottomAppBar _buildBottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      height: 70,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: Colors.white),
            onPressed: () {},
            child: Text(
              "GO TO CHECKOUT",
              style: Theme
                  .of(context)
                  .textTheme
                  .displaySmall,
            ),
          )
        ],
      ),
    );
  }
}
