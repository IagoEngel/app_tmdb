import 'package:app_tmdb/providers/configuracoes_provider.dart';
import 'package:app_tmdb/providers/filmes_provider.dart';
import 'package:app_tmdb/screens/home/widgets/filme_card_widget.dart';
import 'package:app_tmdb/utils/dimensoes_app.dart';
import 'package:app_tmdb/utils/widgets/custom_circular_progress_widget.dart';
import 'package:app_tmdb/utils/widgets/custom_sized_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ConfiguracoesProvider _configuracoesProvider;
  late FilmesProvider _filmesProvider;

  final ScrollController _scrollController = ScrollController();

  bool _carregando = true;
  bool _carregandoMaisFilmes = false;
  int _page = 1;

  Future inicializar() async {
    await Future.wait([
      _configuracoesProvider.getConfiguracoes(),
      _filmesProvider.getGenerosFilmes(),
      _filmesProvider.getFilmesPopulares(_page),
    ]);

    setState(() => _carregando = false);
  }

  @override
  void initState() {
    super.initState();

    _configuracoesProvider = Provider.of(context, listen: false);
    _filmesProvider = Provider.of(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) => inicializar());

    _scrollController.addListener(() async {
      if (!_scrollController.position.atEdge) return;

      bool chegouAoFim = _scrollController.position.pixels > 0;
      if (!chegouAoFim && !_carregandoMaisFilmes) return;

      setState(() => _carregandoMaisFilmes = true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Durations.medium1,
          curve: Curves.linear,
        );
      });

      await _filmesProvider.getFilmesPopulares(++_page);

      setState(() => _carregandoMaisFilmes = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: DimensoesApp.larguraProporcional(10),
            ),
            child: Text(
              'Filmes Populares',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const CustomSizedBoxWidget(height: 16),
          _renderizarListaFilmes(),
        ],
      ),
    );
  }

  Future onRefresh() async {
    setState(() => _carregando = true);

    await _filmesProvider.getFilmesPopulares(1);

    setState(() {
      _page = 1;
      _carregando = false;
    });
  }

  Widget _renderizarListaFilmes() {
    if (_carregando) {
      return const Expanded(
        child: CustomCircularProgressWidget(),
      );
    }

    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: _filmesProvider.listaFilmes.length,
        separatorBuilder: (_, __) => const CustomSizedBoxWidget(height: 12),
        itemBuilder: (_, i) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilmeCardWidget(filme: _filmesProvider.listaFilmes[i]),
            Visibility(
              visible: _carregandoMaisFilmes &&
                  i == _filmesProvider.listaFilmes.length - 1,
              child: Padding(
                padding: EdgeInsets.only(
                  top: DimensoesApp.larguraProporcional(24),
                ),
                child: const CustomCircularProgressWidget(
                  texto: 'Carregando mais filmes...',
                ),
              ),
            ),
            Visibility(
              visible: i == _filmesProvider.listaFilmes.length - 1,
              child: const CustomSizedBoxWidget(height: 24),
            ),
          ],
        ),
      ),
    );
  }
}
