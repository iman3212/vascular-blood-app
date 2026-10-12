import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  // Text style for small display text using Lato font
  static final TextStyle displaySmall = GoogleFonts.lato(
      // fontWeight: FontWeight.w600,
      );

  // Text style for large body text using Lato font
  static final TextStyle bodyLarge = GoogleFonts.lato(
      // fontSize: 17,
      );

  // Text style for medium body text using Lato font with a specific size and weight
  static final TextStyle bodyMedium = GoogleFonts.lato(
    fontSize: 21,
    fontWeight: FontWeight.w700,
  );

  // Text style for small body text using Lato font with a specific size and weight
  static final TextStyle bodysmall = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  // Text style for large titles, used in sign-in and sign-up screens
  static final TextStyle titleLarge = GoogleFonts.lato(
    fontWeight: FontWeight.w800,
    fontSize: 24,
  );

  // Text style for small titles, used in splash screens
  static final TextStyle titleSmall = GoogleFonts.lato(
    fontSize: 18.5,
    color: Colors.grey.shade600,
  );

  // Text style for medium titles
  static final TextStyle titleMedium = GoogleFonts.lato(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
}
