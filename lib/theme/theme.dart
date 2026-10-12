import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vascular_blood/theme/color.dart';
import 'package:vascular_blood/theme/text.dart';

class AppTheme {
  // Light theme configuration
  final ThemeData lightTheme = ThemeData(
      // Enabling Material Design 3
      useMaterial3: true,
      
      // Setting up the color scheme for the light theme
      colorScheme: const ColorScheme.light(
        primary: LightThemeColor.primaryColor, // Primary color used throughout the app
        secondary: LightThemeColor.secondaryColor, // Secondary color used for accents
        surface: LightThemeColor.surface, // Background color for surfaces like cards
      ),

      // Configuring default icon theme settings
      iconTheme: const IconThemeData(
        color: Colors.red, // Default color for icons
        size: 25, // Default size for icons
      ),

      // Configuring default text styles using Google Fonts
      textTheme: GoogleFonts.latoTextTheme().copyWith(
        displaySmall: AppTextTheme.displaySmall, // Text style for smaller display text
        bodyLarge: AppTextTheme.bodyLarge, // Text style for large body text
        bodyMedium: AppTextTheme.bodyMedium, // Text style for medium body text
        bodySmall: AppTextTheme.bodysmall, // Text style for small body text
        titleLarge: AppTextTheme.titleLarge, // Text style for large titles
        titleMedium: AppTextTheme.titleMedium, // Text style for medium titles
        titleSmall: AppTextTheme.titleSmall, // Text style for small titles
      ),

      // Configuring the app bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: LightThemeColor.primaryColor, // Setting the background color for the app bar
      ),

      // Configuring the default style for elevated buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              // Setting the background color for the button
              backgroundColor: const WidgetStatePropertyAll(LightThemeColor.primaryColor),

              // Setting the minimum size for the button
              minimumSize: const WidgetStatePropertyAll(Size(310, 55)),

              // Setting the text color on the button
              foregroundColor: const WidgetStatePropertyAll(LightThemeColor.onPrimary),

              // Setting the shape and border radius for the button
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ))));

  // Placeholder for dark theme configuration
  final ThemeData darkTheme = ThemeData();
}
