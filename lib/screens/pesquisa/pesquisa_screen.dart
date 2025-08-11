import 'dart:async';

import 'package:app_tmdb/view%20model/busca_filmes_view_model.dart';
import 'package:app_tmdb/view%20model/filmes_provider_view_model.dart';
import 'package:app_tmdb/screens/pesquisa/widgets/filme_list_tile_widget.dart';
import 'package:app_tmdb/screens/pesquisa/widgets/lista_generos_filmes_widget.dart';
import 'package:app_tmdb/ui/core/themes/app_tema.dart';
import 'package:app_tmdb/utils/dimensoes_app.dart';
import 'package:app_tmdb/ui/core/widgets/custom_circular_progress_widget.dart';
import 'package:app_tmdb/ui/core/widgets/custom_sized_box_widget.dart';
import 'package:app_tmdb/ui/core/widgets/popup_erro_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PesquisaScreen extends StatefulWidget {
  const PesquisaScreen({super.key});

  @override
  State<PesquisaScreen> createState() => _PesquisaScreenState();
}

class _PesquisaScreenState extends State<PesquisaScreen> {
  late FilmesViewModel _filmesProvider;
  late BuscaFilmesViewModel _buscaFilmesProvider;
  late TextEditingController _controller;
  late ScrollController _scrollController;

  Map<int, String> generosFilme = {};

  int _page = 1;
  int _generoSelecionado = 0;
  bool _carregandoMaisFilmes = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    _filmesProvider = Provider.of(context, listen: false);
    _buscaFilmesProvider = Provider.of(context, listen: false);
    _scrollController = ScrollController();
    _controller = TextEditingController();

    generosFilme = {0: 'Tudo', ..._filmesProvider.generosFilmes};
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: DimensoesApp.larguraProporcional(10),
          ),
          child: Text(
            'Busca',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const CustomSizedBoxWidget(height: 6),
        TextField(
          controller: _controller,
          onChanged: _onChanged,
          decoration: InputDecoration(
            hintText: 'Buscar filmes',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTema.cinzaClaro,
                ),
            prefixIcon: SizedBox.square(
              dimension: DimensoesApp.larguraProporcional(20),
              child: Center(
                child: SvgPicture.asset('assets/icons/busca.svg'),
              ),
            ),
          ),
        ),
        const CustomSizedBoxWidget(height: 16),
        ListaGenerosFilmesWidget(
          generoSelecionado: _generoSelecionado,
          generosFilme: generosFilme,
          onPressed: (i) => setState(() => _generoSelecionado = i),
        ),
        const CustomSizedBoxWidget(height: 22.5),
        Consumer<BuscaFilmesViewModel>(
          builder: (_, buscaFilmesProvider, __) =>
              _renderizarConteudoPesquisa(buscaFilmesProvider),
        ),
      ],
    );
  }

  Widget _renderizarConteudoPesquisa(BuscaFilmesViewModel buscaFilmesProvider) {
    if (buscaFilmesProvider.carregando && !_carregandoMaisFilmes) {
      return const CustomCircularProgressWidget();
    }

    if (buscaFilmesProvider.temErro) {
      WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
            context: context,
            builder: (context) =>
                PopupErroWidget(mensagem: buscaFilmesProvider.mensagemErro),
          ));

      return Expanded(
        child: Center(
          child: OutlinedButton(
            onPressed: () => _buscaFilmesProvider.buscarFilmes(
              1,
              _controller.text.trim(),
              generoId: (generosFilme.entries.toList())[_generoSelecionado].key,
            ),
            child: const Text('Tentar novamente'),
          ),
        ),
      );
    }

    if (buscaFilmesProvider.totalPages != null &&
        _page >= buscaFilmesProvider.totalPages!) {
      WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
            context: context,
            builder: (context) => const PopupErroWidget(
              titulo: 'Aviso',
              mensagem: 'Não há mais filmes para carregar',
            ),
          ));
    }

    return NotificationListener<ScrollNotification>(
      onNotification: onNotification,
      child: Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: buscaFilmesProvider.listaFilmesBuscados.length,
          separatorBuilder: (_, i) => const CustomSizedBoxWidget(height: 10),
          itemBuilder: (_, i) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FilmeListTileWidget(
                filme: buscaFilmesProvider.listaFilmesBuscados[i],
              ),
              Visibility(
                visible: _carregandoMaisFilmes &&
                    i == buscaFilmesProvider.listaFilmesBuscados.length - 1,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: DimensoesApp.larguraProporcional(22.5),
                  ),
                  child: const CustomCircularProgressWidget(
                    texto: 'Carregando mais filmes...',
                  ),
                ),
              ),
              Visibility(
                visible: i == _filmesProvider.listaFilmes.length - 1,
                child: const CustomSizedBoxWidget(height: 22.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    setState(() => _page = 1);

    _debounce = Timer(
        const Duration(milliseconds: 1000),
        () async => await _buscaFilmesProvider.buscarFilmes(
              1,
              value.trim(),
              generoId: (generosFilme.entries.toList())[_generoSelecionado].key,
            ));
  }

  bool onNotification(ScrollNotification notification) {
    if (!notification.metrics.atEdge) return false;

    if (notification is ScrollEndNotification && !_carregandoMaisFilmes) {
      setState(() => _carregandoMaisFilmes = true);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Durations.medium1,
          curve: Curves.linear,
        );
      });

      _buscaFilmesProvider
          .buscarFilmes(
            ++_page,
            _controller.text.trim(),
            generoId: (generosFilme.entries.toList())[_generoSelecionado].key,
          )
          .then((_) => setState(() => _carregandoMaisFilmes = false));
    }

    return false;
  }
}
