import 'package:app_tmdb/utils/dimensoes_app.dart';
import 'package:flutter/material.dart';

abstract class AppTema {
  static Color fundo = const Color(0xFF1A1A1A);
  static Color cinza = const Color(0xFF292E34);
  static Color borda = const Color(0xFF4E4E4E);
  static Color cinzaClaro = const Color(0xFFA6BACF);
  static Color destaque = const Color(0xFF2B64DF);
  static Color corIcone = Colors.white;
  static Color corFloatingNav = Colors.black;

  static temaBaseEscuro() {
    fundo = const Color(0xFF1A1A1A);
    cinza = const Color(0xFF292E34);
    borda = const Color(0xFF4E4E4E);
    cinzaClaro = const Color(0xFFA6BACF);
    destaque = const Color(0xFF2B64DF);
    corIcone = Colors.white;
    corFloatingNav = Colors.black;

    return ThemeData(
      scaffoldBackgroundColor: fundo,
      visualDensity: VisualDensity.compact,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cinza,
        border: _outlinedBorderComum(borderColor: borda),
        focusedBorder: _outlinedBorderComum(borderColor: destaque),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(corIcone),
        ),
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
  }

  static temaBaseClaro() {
    fundo = const Color(0xFFDFDFDF);
    cinza = const Color(0xFF9BAEC5);
    borda = const Color(0xFF8A8A8A);
    cinzaClaro = const Color(0xFF31373D);
    destaque = const Color(0xFFDEA72A);
    corIcone = Colors.black;
    corFloatingNav = Colors.white;

    return ThemeData(
      scaffoldBackgroundColor: fundo,
      visualDensity: VisualDensity.compact,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cinza,
        border: _outlinedBorderComum(borderColor: borda),
        focusedBorder: _outlinedBorderComum(borderColor: destaque),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(corIcone),
        ),
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
  }

  static TextStyle _textStyleComum(double? fontSize) {
    return TextStyle(
      color: corIcone,
      fontSize: DimensoesApp.larguraProporcional(fontSize),
    );
  }

  static OutlineInputBorder _outlinedBorderComum({required Color borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(99),
      borderSide: BorderSide(color: borderColor),
    );
  }
}
