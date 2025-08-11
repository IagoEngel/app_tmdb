import 'package:app_tmdb/ui/core/widgets/custom_sized_box_widget.dart';
import 'package:app_tmdb/ui/core/widgets/shimmer_imagem_widget.dart';
import 'package:flutter/material.dart';

class InfoCardWidget extends StatelessWidget {
  final String imagePath;
  final String titulo;
  final String subTitulo;
  final String tipoImagem;

  const InfoCardWidget({
    super.key,
    required this.imagePath,
    required this.titulo,
    required this.subTitulo,
    this.tipoImagem = 'profile',
  });

  @override
  Widget build(BuildContext context) {
    const double width = 110;
    const double height = 112;

    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShimmerImagemWidget(
            imagePath: imagePath,
            width: width,
            height: height,
            tipoImagem: tipoImagem,
          ),
          const CustomSizedBoxWidget(height: 4),
          _renderizarNomeCargo(context),
        ],
      ),
    );
  }

  Widget _renderizarNomeCargo(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            titulo,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Visibility(
            visible: subTitulo.isNotEmpty,
            child: Text(
              subTitulo,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
