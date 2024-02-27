import 'package:flutter/material.dart';
import 'package:e_commerce/presentation/widgets/widgets.dart';

class UserScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile"),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
