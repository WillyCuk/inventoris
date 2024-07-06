import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool obscure;

  const MyTextField(
      {super.key,
      required this.text,
      required this.controller,
      required this.obscure});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
            labelText: text,
            labelStyle: GoogleFonts.quicksand(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ))),
      ),
    );
  }
}
