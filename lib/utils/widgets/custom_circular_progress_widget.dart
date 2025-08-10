import 'package:app_tmdb/utils/app_tema.dart';
import 'package:app_tmdb/utils/widgets/custom_sized_box_widget.dart';
import 'package:flutter/material.dart';

class CustomCircularProgressWidget extends StatelessWidget {
  final String texto;

  const CustomCircularProgressWidget({
    super.key,
    this.texto = 'Carregando...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: AppTema.azul),
          const CustomSizedBoxWidget(height: 4),
          Text(
            texto,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
