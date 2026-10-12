import 'package:flutter/material.dart';

/// A class defining the color palette for the light theme of the application.
/// This class contains static color constants that can be used throughout the app
class LightThemeColor {
  /// The primary color of the theme, used for prominent UI elements like buttons and app bars.
  static const primaryColor = Color.fromARGB(255, 226, 49, 36);

  /// The secondary color of the theme, used for accents and complementary UI elements.
  static const secondaryColor = Colors.black;

  /// The color used for text and icons that appear on top of the primary color.
  static const onPrimary = Colors.white;

  /// The background color of the app, typically used for the scaffold or main container.
  static const backgroundColor = Colors.white;

  /// The surface color, used for surfaces of components like cards and sheets.
  static const surface = Colors.white;

  /// The primary text color, used for most text in the app.
  static const primaryTextColor = Color.fromARGB(255, 35, 35, 35);

  /// The secondary text color, used for less prominent text like captions or hints.
  static const secondaryTextColor = Color.fromARGB(255, 85, 86, 88);
}

/// A class defining the color palette for the dark theme of the application.
/// This class is currently empty and can be extended with dark theme color constants
  // Placeholder for dark theme configuration
class DarkThemeColor {}

/// A utility class for converting hexadecimal color codes into Flutter [Color] objects.
/// This class extends the [Color] class and provides a constructor to create colors
/// from hexadecimal strings (e.g., "#FF5733" or "FF5733").
class HexColor extends Color {
  /// Constructs a [HexColor] from a hexadecimal color string.
  ///
  /// Parameters:
  /// - [hexColor]: A string representing the hexadecimal color code (e.g., "#FF5733" or "FF5733").
 
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  /// Converts a hexadecimal color string into an integer representation of the color.
  ///
  /// Parameters:
  /// - [hexColor]: A string representing the hexadecimal color code.
  ///
  /// Returns:
  /// - An integer representing the color in ARGB format.
  ///
  /// Throws:
  /// - [FormatException] if the string is not a valid hexadecimal color code.
  static int _getColorFromHex(String hexColor) {
    // Remove the '#' character if present and convert the string to uppercase.
    hexColor = hexColor.toUpperCase().replaceAll('#', '');

    // If the hexadecimal string is 6 characters long, prepend 'FF' to make it 8 characters (ARGB format).
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }

    // Parse the hexadecimal string into an integer with a radix of 16.
    return int.parse(hexColor, radix: 16);
  }
}
