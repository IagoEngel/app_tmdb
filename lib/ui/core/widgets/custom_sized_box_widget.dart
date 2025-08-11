import 'package:app_tmdb/utils/dimensoes_app.dart';
import 'package:flutter/material.dart';

class CustomSizedBoxWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const CustomSizedBoxWidget({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DimensoesApp.larguraProporcional(width),
      height: DimensoesApp.alturaProporcional(height),
    );
  }
}
