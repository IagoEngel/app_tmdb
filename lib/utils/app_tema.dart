import 'package:app_tmdb/utils/dimensoes_app.dart';
import 'package:flutter/material.dart';

abstract class AppTema {
  static const fundoEscuro = Color(0xFF1A1A1A);
  static const cinza = Color(0xFF292E34);
  static const bordaCinza = Color(0xFF4E4E4E);
  static const cinzaClaro = Color(0xFFA6BACF);
  static const azul = Color(0xFF2B64DF);

  static final theme = ThemeData(
    scaffoldBackgroundColor: fundoEscuro,
    visualDensity: VisualDensity.compact,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cinza,
      border: _outlinedBorderComum(),
      focusedBorder: _outlinedBorderComum(borderColor: azul),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: cinza,
      side: BorderSide.none,
      labelStyle: _textStyleComum(14).copyWith(
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(99),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: DimensoesApp.larguraProporcional(10),
        vertical: DimensoesApp.larguraProporcional(8),
      ),
    ),
    textTheme: TextTheme(
      bodySmall: _textStyleComum(12),
      bodyMedium: _textStyleComum(14),
      bodyLarge: _textStyleComum(16),
      titleSmall: _textStyleComum(18).copyWith(
        fontWeight: FontWeight.bold,
      ),
      titleMedium: _textStyleComum(20).copyWith(
        fontWeight: FontWeight.bold,
      ),
      titleLarge: _textStyleComum(22).copyWith(
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static TextStyle _textStyleComum(double? fontSize) {
    return TextStyle(
      color: Colors.white,
      fontSize: DimensoesApp.larguraProporcional(fontSize),
    );
  }

  static OutlineInputBorder _outlinedBorderComum(
      {Color borderColor = bordaCinza}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(99),
      borderSide: BorderSide(color: borderColor),
    );
  }
}
