import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  const MyTextFormField(
      {super.key,
      required this.controller,
      required this.validator,
      required this.labelText,
      required this.prefixIcon,
      required this.suffixIcon,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,
          labelStyle: GoogleFonts.quicksand(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.primary),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ))),
    );
  }
}
