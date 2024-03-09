import 'package:e_commerce/config/theme.dart';
import 'package:e_commerce/constants/strings.dart';
import 'package:e_commerce/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/checkout/checkout_bloc.dart';
import '../widgets/order_summary_widget.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() {
    return _CheckoutScreenState();
  }
}

class _CheckoutScreenState extends State<CheckoutScreen> {
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
    return Scaffold(
      appBar: const CustomAppBar(title: "Checkout"),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CheckoutLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("CUSTOMER INFORMATION",
                      style: theme().textTheme.displaySmall),
                  _buildTextFormField((value) {
                    context
                        .read<CheckoutBloc>()
                        .add(UpdateCheckout(email: value));
                  }, context, "Email"),
                  _buildTextFormField((value) {
                    context
                        .read<CheckoutBloc>()
                        .add(UpdateCheckout(fullName: value));
                  }, context, "Name"),
                  Text("DELIVERY INFORMATION",
                      style: theme().textTheme.displaySmall),
                  _buildTextFormField((value) {
                    context
                        .read<CheckoutBloc>()
                        .add(UpdateCheckout(address: value));
                  }, context, "Address"),
                  _buildTextFormField((value) {
                    context
                        .read<CheckoutBloc>()
                        .add(UpdateCheckout(city: value));
                  }, context, "City"),
                  _buildTextFormField((value) {
                    context
                        .read<CheckoutBloc>()
                        .add(UpdateCheckout(country: value));
                  }, context, "Country"),
                  Text("ORDER SUMMARY", style: theme().textTheme.displaySmall),
                  OrderSumarryWidget()
                ],
              );
            } else {
              return const Center(child: Text("Something is wrong"));
            }
          },
        ),
      ),
    );
  }

  BottomAppBar _buildBottomNavigationBar(BuildContext context) {
    return BottomAppBar(
        height: 70,
        color: Colors.black,
        child: BlocConsumer<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CheckoutLoaded) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: Colors.white),
                onPressed: () {
                  // context
                  //     .read<CheckoutBloc>()
                  //     .add(ConfirmCheckout(checkout: state.checkoutModel));
                  Navigator.pushNamed(context, orderConfirmationScreen);
                },
                child: Text(
                  "ORDER",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              );
            } else {
              return const Center(child: Text("Somethins is Wrong"));
            }
          },
          listener: (context, state) {
            if (state is CheckoutSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Purchase completed successfully!',
                      style: TextStyle(color: Colors.orange)),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
        ));
  }

  Widget _buildTextFormField(
    Function(String)? onChanged,
    BuildContext context,
    String labelText,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        SizedBox(
          width: 70,
          child: Text(labelText, style: theme().textTheme.bodyLarge),
        ),
        Expanded(
          child: TextFormField(
            onChanged: onChanged,
            decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(left: 10),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black))),
          ),
        ),
      ]),
    );
  }
}
