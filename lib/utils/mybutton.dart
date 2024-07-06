import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          elevation: 0,
          minimumSize: Size(MediaQuery.sizeOf(context).width * .45, 65),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      child: Text(
        text,
        style: GoogleFonts.quicksand(
            fontSize: 18,
            // fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.inversePrimary),
      ),
    );
  }
}
