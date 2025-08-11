import 'package:app_tmdb/domain/models/filme_model.dart';
import 'package:app_tmdb/providers/filmes_provider.dart';
import 'package:app_tmdb/screens/detalhes%20filme/widgets/elenco_filme_widget.dart';
import 'package:app_tmdb/screens/detalhes%20filme/widgets/filmes_similares_widget.dart';
import 'package:app_tmdb/screens/detalhes%20filme/widgets/recomendacoes_widget.dart';
import 'package:app_tmdb/ui/core/themes/app_tema.dart';
import 'package:app_tmdb/utils/dimensoes_app.dart';
import 'package:app_tmdb/ui/core/widgets/custom_circular_progress_widget.dart';
import 'package:app_tmdb/ui/core/widgets/custom_sized_box_widget.dart';
import 'package:app_tmdb/ui/core/widgets/shimmer_imagem_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetalhesFilmeScreen extends StatefulWidget {
  final int movieId;

  const DetalhesFilmeScreen({
    super.key,
    required this.movieId,
  });

  @override
  State<DetalhesFilmeScreen> createState() => _DetalhesFilmeScreenState();
}

class _DetalhesFilmeScreenState extends State<DetalhesFilmeScreen> {
  late FilmesProvider _filmesProvider;
  late FilmeModel _filme;

  final double _tamanho8 = DimensoesApp.larguraProporcional(8);
  final double _tamanho16 = DimensoesApp.larguraProporcional(16);
  final double _tamanho24 = DimensoesApp.larguraProporcional(24);
  final double _tamanho168 = DimensoesApp.larguraProporcional(168);

  bool carregando = true;

  @override
  void initState() {
    super.initState();

    _filmesProvider = Provider.of(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _filme = await _filmesProvider.getDetalhesFilmes(widget.movieId);
      final membrosElenco = await _filmesProvider.getElenco(widget.movieId);
      _filme.cast = membrosElenco.cast;
      _filme.crew = membrosElenco.crew;

      setState(() => carregando = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _renderizarConteudo()),
    );
  }

  Widget _renderizarConteudo() {
    if (carregando) {
      return const CustomCircularProgressWidget();
    }

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          expandedHeight: DimensoesApp.larguraProporcional(160),
          flexibleSpace: FlexibleSpaceBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: DimensoesApp.larguraProporcional(12),
                  color: AppTema.corIcone,
                ),
                Text(
                  _filme.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            background: ShimmerImagemWidget(
              imagePath: _filme.backdropPath,
              tipoImagem: 'backdrop',
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: EdgeInsets.fromLTRB(
                _tamanho16,
                _tamanho8,
                _tamanho16,
                _tamanho24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Visão geral do filme:\n',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: _filme.overview.isNotEmpty
                              ? _filme.overview
                              : 'Descrição não encontrada',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    ),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const CustomSizedBoxWidget(height: 8),
                  ElencoFilmeWidget(
                    titulo: 'Elenco:',
                    elenco: _filme.cast,
                    height: _tamanho168,
                  ),
                  const CustomSizedBoxWidget(height: 8),
                  ElencoFilmeWidget(
                    titulo: 'Equipe:',
                    elenco: _filme.crew,
                    height: _tamanho168,
                  ),
                  const CustomSizedBoxWidget(height: 8),
                  FilmesSimilaresWidget(
                    movieId: widget.movieId,
                    height: _tamanho168,
                  ),
                  const CustomSizedBoxWidget(height: 8),
                  RecomendacoesWidget(
                    movieId: widget.movieId,
                    height: _tamanho168,
                  ),
                ],
              ),
            ),
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
