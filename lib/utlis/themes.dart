import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeClass {
  // ignore: non_constant_identifier_names
  ThemeData theme = ThemeData(
      primaryColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 5,
        titleTextStyle: TextStyle(
            fontFamily: GoogleFonts.lato().fontFamily,
            fontSize: 20,
            fontWeight: FontWeight.w500),
        color: Colors.grey[900],
      ),
      textTheme: TextTheme(
          headline1: GoogleFonts.lato(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      )));
}
