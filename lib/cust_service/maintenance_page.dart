import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Maintenance extends StatelessWidget {
  const Maintenance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maintenance"),
      ),
      body: Center(
        child: LottieBuilder.asset("assets/maintenance.json"),
      ),
    );
  }
}
