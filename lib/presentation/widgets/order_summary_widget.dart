import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/cart/cart_bloc.dart';
import '../../config/theme.dart';

class OrderSumarryWidget extends StatelessWidget {
  OrderSumarryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Column(
            children: [
              const Divider(thickness: 2),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
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
                          "\$${state.cart.subTotal.toStringAsFixed(2)}",
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
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    color: Colors.grey,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: const EdgeInsets.all(5),
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          );
        }else{
          return Center();
        }
      },
    );
  }
}
