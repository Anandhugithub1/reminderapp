import 'package:flutter/material.dart';

class Pallete {
  static const Color backgroundColor = Color.fromRGBO(24, 24, 32, 1);
  static const Color gradient1 = Colors.red;
  static const Color gradient2 = Colors.white12;
  static const Color gradient3 = Color.fromRGBO(255, 255, 124, 1);
  static const Color borderColor = Colors.white12;
  static const Color whiteColor = Colors.white;

  static const primaryColor = Color.fromRGBO(255, 127, 80, 1);
  // Secondary Color: RGB(255, 160, 122) (Light Salmon)
  static const secondaryColor = Color.fromRGBO(255, 160, 122, 1);

  static const accentColor = Color.fromRGBO(250, 128, 114, 1);
  // Accent Color: RGB(250, 128, 114) (Salmon)

  static const LinearGradient coralGradient = LinearGradient(
    colors: [
      Color.fromRGBO(255, 127, 80, 1.0), // Coral (RGB: 255, 127, 80)
      Color.fromRGBO(255, 160, 122, 1.0), // Light Salmon (RGB: 255, 160, 122)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
