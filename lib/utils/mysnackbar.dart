import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      content: Text(message,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.primary,
          )),
      duration: const Duration(seconds: 3), // Increased duration
      behavior: SnackBarBehavior.floating,
    ),
  );
}

void showTopSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: EdgeInsets.fromLTRB(
          10, 0, 10, MediaQuery.sizeOf(context).height * .58),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      content: Text(message,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.primary,
          )),
      duration: const Duration(seconds: 3), // Increased duration
      behavior: SnackBarBehavior.floating,
    ),
  );
}
