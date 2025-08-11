import 'package:app_tmdb/domain/models/filme_model.dart';
import 'package:app_tmdb/providers/filmes_provider.dart';
import 'package:app_tmdb/ui/core/widgets/shimmer_imagem_widget.dart';
import 'package:app_tmdb/ui/core/themes/app_tema.dart';
import 'package:app_tmdb/utils/dimensoes_app.dart';
import 'package:app_tmdb/ui/core/widgets/custom_sized_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FilmeCardWidget extends StatefulWidget {
  final FilmeModel filme;

  const FilmeCardWidget({
    super.key,
    required this.filme,
  });

  @override
  State<FilmeCardWidget> createState() => _FilmeCardWidgetState();
}

class _FilmeCardWidgetState extends State<FilmeCardWidget> {
  late FilmesProvider _filmesProvider;

  final double _tamanho8 = DimensoesApp.larguraProporcional(8);
  final double _tamanho10 = DimensoesApp.larguraProporcional(10);
  final double _tamanho12 = DimensoesApp.larguraProporcional(12);
  final double _tamanho40 = DimensoesApp.larguraProporcional(40);

  @override
  void initState() {
    super.initState();

    _filmesProvider = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_tamanho8),
      decoration: BoxDecoration(
        color: AppTema.cinza,
        borderRadius: BorderRadius.circular(_tamanho12),
      ),
      child: Row(
        children: [
          ShimmerImagemWidget(imagePath: widget.filme.posterPath),
          _renderizarInfoPrincipais(),
          _renderizarAvaliacao(),
        ],
      ),
    );
  }

  Widget _renderizarInfoPrincipais() {
    final String dataLancamento = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(widget.filme.releaseDate));
    final String generos = widget.filme.genreIds
        .map((id) => _filmesProvider.generosFilmes[id] ?? 'Não encontrado')
        .join(', ');

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: _tamanho12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.filme.title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const CustomSizedBoxWidget(height: 8),
            Text(
              'Ano de lançamento: $dataLancamento',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTema.cinzaClaro,
                  ),
            ),
            Text(
              'Genêros: $generos',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTema.cinzaClaro,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderizarAvaliacao() {
    return Container(
      width: _tamanho40,
      height: _tamanho40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppTema.destaque,
        borderRadius: BorderRadius.circular(_tamanho10),
      ),
      child: Text(
        (widget.filme.voteAverage * 10).toStringAsFixed(0),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
