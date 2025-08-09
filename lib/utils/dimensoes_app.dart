import 'package:flutter/material.dart';

class DimensoesApp {
  static double largura = 0;
  static double altura = 0;

  DimensoesApp(MediaQueryData data) {
    largura = data.size.width;
    altura = data.size.height;
  }

  static Map valores = {};

  static double larguraProporcional(double? y) {
    if (y == null || y == 0) return 0;

    valores.putIfAbsent(y, () => y * largura / 360);

    return valores[y];
  }

  static double alturaProporcional(double? x) {
    if (x == null || x == 0) return 0;

    valores.putIfAbsent(x, () => x * altura / 640);

    return valores[x];
  }
}
