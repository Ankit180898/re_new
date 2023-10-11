import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  // Example: Create a method for a title text style
  static TextStyle titleTextStyle({
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.bold,
    Color color = Colors.black,
  }) {
    return GoogleFonts.openSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Add more methods for other text styles as needed
  static TextStyle bodyTextStyle({
    double fontSize = 16,
    Color color = Colors.black,
  }) {
    return GoogleFonts.openSans(
      fontSize: fontSize,
      color: color,
    );
  }
}
