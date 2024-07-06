import 'package:flutter/material.dart';

class MyLogo extends StatelessWidget {
  const MyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .25,
      child: Image.asset(
        "assets/logo.png",
        fit: BoxFit.fitHeight,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
