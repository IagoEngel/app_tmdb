import 'package:flutter/material.dart';

abstract class AppTema {
  static const fundoEscuro = Color(0xFF1A1A1A);
  static const cinza = Color(0xFF292E34);
  static const cinzaClaro = Color(0xFFA6BACF);
  static const azul = Color(0xFF2B64DF);

  static final theme = ThemeData(
    scaffoldBackgroundColor: fundoEscuro,
    visualDensity: VisualDensity.compact,
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
