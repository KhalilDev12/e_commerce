import 'package:e_commerce/config/theme.dart';
import 'package:e_commerce/presentation/widgets/custom_appbar.dart';
import 'package:e_commerce/presentation/widgets/order_summary_widget.dart';
import 'package:flutter/material.dart';

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
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController countryController = TextEditingController();
    final TextEditingController zipCodeController = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(title: "Checkout"),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("CUSTOMER INFORMATION", style: theme().textTheme.displaySmall),
            _buildTextFormField(emailController, context, "Email"),
            _buildTextFormField(nameController, context, "Name"),
            Text("DELIVERY INFORMATION", style: theme().textTheme.displaySmall),
            _buildTextFormField(addressController, context, "Address"),
            _buildTextFormField(cityController, context, "City"),
            _buildTextFormField(countryController, context, "Country"),
            _buildTextFormField(zipCodeController, context, "Zip Code"),
            Text("ORDER SUMMARY", style: theme().textTheme.displaySmall),
            OrderSumarryWidget()
          ],
        ),
      ),
    );
  }

  BottomAppBar _buildBottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      height: 70,
      color: Colors.black,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: Colors.white),
        onPressed: () {},
        child: Text(
          "ORDER",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }

  Widget _buildTextFormField(
    TextEditingController controller,
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
            controller: controller,
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
