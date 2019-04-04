import 'package:flutter/material.dart';

class Themer {
  //function checks if dark theme is set and returns appropriate color
  static Color setColor(
      BuildContext context, Color color, Color secondaryColor) {
    return Theme.of(context).brightness == Brightness.dark
        ? secondaryColor == null ? Colors.white : secondaryColor
        : color;
  }
}
