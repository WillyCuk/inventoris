import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  const ItemTextField(
      {super.key, required this.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.quicksand(fontSize: 14, color: Colors.blueGrey),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primaryContainer,
          ))),
        ),
      ],
    );
  }
}
