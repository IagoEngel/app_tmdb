import 'dart:async';

import 'package:app_tmdb/providers/busca_filmes_provider.dart';
import 'package:app_tmdb/providers/filmes_provider.dart';
import 'package:app_tmdb/screens/pesquisa/widgets/filme_list_tile_widget.dart';
import 'package:app_tmdb/screens/pesquisa/widgets/lista_generos_filmes_widget.dart';
import 'package:app_tmdb/utils/app_tema.dart';
import 'package:app_tmdb/utils/dimensoes_app.dart';
import 'package:app_tmdb/utils/widgets/custom_circular_progress_widget.dart';
import 'package:app_tmdb/utils/widgets/custom_sized_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PesquisaScreen extends StatefulWidget {
  const PesquisaScreen({super.key});

  @override
  State<PesquisaScreen> createState() => _PesquisaScreenState();
}

class _PesquisaScreenState extends State<PesquisaScreen> {
  late FilmesProvider _filmesProvider;
  late BuscaFilmesProvider _buscaFilmesProvider;
  late TextEditingController _controller;

  final ScrollController _scrollController = ScrollController();

  Map<int, String> generosFilme = {};

  int _page = 1;
  int _generoSelecionado = 0;
  bool _carregando = false;
  bool _carregandoMaisFilmes = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    _filmesProvider = Provider.of(context, listen: false);
    _buscaFilmesProvider = Provider.of(context, listen: false);

    generosFilme = {0: 'Tudo', ..._filmesProvider.generosFilmes};

    _controller = TextEditingController(text: 'vingadore');

    _scrollController.addListener(() async {
      print(_scrollController.position);
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

      await _buscaFilmesProvider.buscarFilmes(++_page, _controller.text.trim());
      setState(() => _carregandoMaisFilmes = false);
    });
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
        Consumer<BuscaFilmesProvider>(
          builder: (_, buscaFilmesProvider, __) {
            if (_carregando) {
              return const Expanded(
                child: CustomCircularProgressWidget(),
              );
            }

            return Expanded(
              child: ListView.separated(
                controller: _scrollController,
                itemCount: buscaFilmesProvider.listaFilmesBuscados.length,
                separatorBuilder: (_, i) =>
                    const CustomSizedBoxWidget(height: 10),
                itemBuilder: (_, i) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FilmeListTileWidget(
                        filme: buscaFilmesProvider.listaFilmesBuscados[i],
                      ),
                      Visibility(
                        visible: _carregandoMaisFilmes &&
                            i ==
                                buscaFilmesProvider.listaFilmesBuscados.length -
                                    1,
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
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    setState(() {
      _carregando = true;
      _page = 1;
    });

    _debounce = Timer(const Duration(milliseconds: 700), () async {
      await _buscaFilmesProvider.buscarFilmes(
        1,
        value.trim(),
        generoId: (generosFilme.entries.toList())[_generoSelecionado].key,
      );
      setState(() => _carregando = false);
    });
  }
}
