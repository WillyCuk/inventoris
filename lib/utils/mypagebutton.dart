import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPageButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final void Function()? onPressed;

  const MyPageButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          elevation: 0,
          minimumSize: Size(width, height),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      child: Text(
        text,
        style: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.inversePrimary),
      ),
    );
  }
}
