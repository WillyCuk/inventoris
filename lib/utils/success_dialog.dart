import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSuccessDialog({required BuildContext context, required String msg}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: Icon(Icons.done,
            color: Theme.of(context).colorScheme.primary, size: 40),
        title: Text(
          'Success',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        content: Text(
          msg,
          style: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog;
            },
            child: Text(
              'OK',
              style: GoogleFonts.poppins(),
            ),
          ),
        ],
      );
    },
  );
}
