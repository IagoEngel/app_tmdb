import 'package:app_tmdb/view%20model/recomendacoes_view_model.dart';
import 'package:app_tmdb/screens/detalhes%20filme/widgets/info_card_widget.dart';
import 'package:app_tmdb/ui/core/widgets/custom_circular_progress_widget.dart';
import 'package:app_tmdb/ui/core/widgets/custom_sized_box_widget.dart';
import 'package:app_tmdb/ui/core/widgets/popup_erro_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecomendacoesWidget extends StatefulWidget {
  final int movieId;
  final double height;

  const RecomendacoesWidget({
    super.key,
    required this.movieId,
    required this.height,
  });

  @override
  State<RecomendacoesWidget> createState() => _RecomendacoesWidgetState();
}

class _RecomendacoesWidgetState extends State<RecomendacoesWidget> {
  late RecomendacoesViewModel _recomendacoesProvider;

  @override
  void initState() {
    super.initState();

    _recomendacoesProvider = Provider.of(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _recomendacoesProvider.getRecomendacoes(widget.movieId));
  }

  @override
  void dispose() {
    super.dispose();

    _recomendacoesProvider.resetProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recomendações: ',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Consumer<RecomendacoesViewModel>(
          builder: (_, providerAux, __) => _renderizarConteudo(providerAux),
        ),
      ],
    );
  }

  Widget _renderizarConteudo(RecomendacoesViewModel providerAux) {
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
