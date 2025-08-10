import 'package:app_tmdb/models/filme_model.dart';
import 'package:app_tmdb/screens/home/widgets/poster_filme_widget.dart';
import 'package:app_tmdb/utils/app_tema.dart';
import 'package:app_tmdb/utils/dimensoes_app.dart';
import 'package:flutter/material.dart';

class FilmeListTileWidget extends StatelessWidget {
  final FilmeModel filme;

  const FilmeListTileWidget({
    super.key,
    required this.filme,
  });

  @override
  Widget build(BuildContext context) {
    double tamanho8 = DimensoesApp.larguraProporcional(8);

    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, tamanho8),
      leading: PosterFilmeWidget(
        posterPath: filme.posterPath,
        width: 32,
        height: 32,
        radius: 6,
      ),
      title: Text(
        filme.title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
      shape: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppTema.cinza),
      ),
    );
  }
}
