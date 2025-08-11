import 'package:app_tmdb/providers/filmes_similares_provider.dart';
import 'package:app_tmdb/screens/detalhes%20filme/widgets/info_card_widget.dart';
import 'package:app_tmdb/ui/core/widgets/custom_circular_progress_widget.dart';
import 'package:app_tmdb/ui/core/widgets/custom_sized_box_widget.dart';
import 'package:app_tmdb/ui/core/widgets/popup_erro_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilmesSimilaresWidget extends StatefulWidget {
  final int movieId;
  final double height;

  const FilmesSimilaresWidget({
    super.key,
    required this.movieId,
    required this.height,
  });

  @override
  State<FilmesSimilaresWidget> createState() => _FilmesSimilaresWidgetState();
}

class _FilmesSimilaresWidgetState extends State<FilmesSimilaresWidget> {
  late FilmesSimilaresProvider _filmesSimilaresProvider;

  @override
  void initState() {
    super.initState();

    _filmesSimilaresProvider = Provider.of(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _filmesSimilaresProvider.getFilmesSimilares(widget.movieId));
  }

  @override
  void dispose() {
    super.dispose();

    _filmesSimilaresProvider.resetProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filmes similares: ',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Consumer<FilmesSimilaresProvider>(
          builder: (_, providerAux, __) => _renderizarConteudo(providerAux),
        ),
      ],
    );
  }

  Widget _renderizarConteudo(FilmesSimilaresProvider providerAux) {
    if (providerAux.carregando) {
      return const CustomCircularProgressWidget();
    }

    if (providerAux.temErro) {
      WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
            context: context,
            builder: (context) =>
                PopupErroWidget(mensagem: providerAux.mensagemErro),
          ));
    }

    return SizedBox(
      height: widget.height,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: providerAux.listaFilmes.length,
        separatorBuilder: (_, __) => const CustomSizedBoxWidget(width: 8),
        itemBuilder: (_, i) {
          final item = providerAux.listaFilmes[i];

          return InfoCardWidget(
            imagePath: item.posterPath,
            titulo: item.title,
            subTitulo: '',
            tipoImagem: 'poster',
          );
        },
      ),
    );
  }
}
