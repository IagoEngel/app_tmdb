import 'package:app_tmdb/ui/core/themes/app_tema.dart';
import 'package:app_tmdb/ui/core/widgets/custom_sized_box_widget.dart';
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
          CircularProgressIndicator(color: AppTema.destaque),
          const CustomSizedBoxWidget(height: 4),
          Text(
            texto,
            style: TextStyle(color: AppTema.corIcone),
          ),
        ],
      ),
    );
  }
}
