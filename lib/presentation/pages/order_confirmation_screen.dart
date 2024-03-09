import 'package:e_commerce/business_logic/blocs/checkout/checkout_bloc.dart';
import 'package:e_commerce/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';

class OrderConfirmationScreen extends StatefulWidget {
  OrderConfirmationScreen({Key? key}) : super(key: key);

  @override
  _OrderConfirmationScreenState createState() {
    return _OrderConfirmationScreenState();
  }
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  late double deviceHeight, deviceWidth;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const CustomAppBar(title: "Order Confirmation"),
      //extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: deviceHeight * 0.3,
              color: Colors.black,
              child: Center(
                child: Text(
                  "Your order is Complete!",
                  style: theme()
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  state as CheckoutLoaded;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order Code: k12dsbage",
                          style: theme().textTheme.displaySmall),
                      SizedBox(height: deviceHeight * 0.01),
                      Text("Thank you for purchasing from Zero to Unicorn",
                          style: theme().textTheme.bodyLarge),
                      SizedBox(height: deviceHeight * 0.01),
                      Text("Order Code: k12dsbage",
                          style: theme().textTheme.displaySmall),
                      OrderSumarryWidget(),
                      const SizedBox(height: 15),
                      Text(
                        "Order Details",
                        style: theme().textTheme.displaySmall,
                      ),
                      const Divider(height: 2),
                      ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          state.products!.length,
                          (index) => OrderConfirmationItem(
                              cartProduct: state.products![index]),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
