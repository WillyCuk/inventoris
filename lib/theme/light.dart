import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  appBarTheme: AppBarTheme(
    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
    backgroundColor: const Color.fromARGB(255, 5, 44, 96),
    titleTextStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
  ),
  datePickerTheme: const DatePickerThemeData(
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: const Color.fromRGBO(5, 44, 96, 0.82),
    contentTextStyle: GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.black,
    thickness: 3,
  ),
  colorScheme: const ColorScheme.light(
    background: Color.fromARGB(255, 255, 255, 255),
    primary: Colors.black,
    secondary: Color.fromRGBO(0, 0, 0, 0.6),
    tertiary: Colors.white,
    inversePrimary: Color.fromARGB(255, 255, 255, 255),
    primaryContainer: Color.fromRGBO(5, 44, 96, 0.95),
    secondaryContainer: Color.fromRGBO(5, 44, 96, 0.5),
  ),
);
