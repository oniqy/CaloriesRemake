import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData LightMode = ThemeData(
    brightness: Brightness.light,
    textTheme: GoogleFonts.poppinsTextTheme(),
    colorScheme: ColorScheme.light(
        background: Colors.grey.shade100,
        primary: Colors.grey.shade900,
        outline: Color(0xE5E3E3E3),
        onSecondary:Colors.grey.shade100,
    )
);

ThemeData DarkMode = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Colors.grey.shade900,
        primary: Colors.white,
        outline: Color(0xFF363636),
        onSecondary:Color(0xFF363636)
    )
);
