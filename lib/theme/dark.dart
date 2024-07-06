import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkMode = ThemeData(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      foregroundColor: const Color.fromARGB(255, 5, 44, 96),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      titleTextStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: const Color.fromARGB(255, 5, 44, 96)),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color.fromARGB(255, 5, 44, 96),
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: Color.fromARGB(255, 5, 44, 96),
    ),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color.fromRGBO(242, 242, 242, 0.82),
        contentTextStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          color: Colors.black,
        )),
    drawerTheme:
        const DrawerThemeData(backgroundColor: Color.fromARGB(255, 5, 44, 96)),
    dividerTheme: const DividerThemeData(color: Colors.white, thickness: 3),
    colorScheme: const ColorScheme.dark(
      background: Color.fromARGB(255, 5, 44, 96),
      primary: Colors.white,
      secondary: Color.fromRGBO(255, 255, 255, .6),
      tertiary: Colors.black,
      inversePrimary: Color.fromARGB(204, 5, 44, 96),
      primaryContainer: Color.fromRGBO(242, 242, 242, 0.82),
      secondaryContainer: Color.fromRGBO(242, 242, 242, 0.5),
    ));
