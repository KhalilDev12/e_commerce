import 'package:e_commerce/config/theme.dart';
import 'package:flutter/material.dart';

import '../../constants/strings.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3))
        .then((value) => Navigator.pushReplacementNamed(context, mainScreen));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.black,
          child: Text(
            "Zero to unicorn",
            style:
                theme().textTheme.displayLarge!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
