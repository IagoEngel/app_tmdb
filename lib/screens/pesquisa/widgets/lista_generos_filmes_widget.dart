import 'package:app_tmdb/utils/app_tema.dart';
import 'package:app_tmdb/utils/dimensoes_app.dart';
import 'package:app_tmdb/utils/widgets/custom_sized_box_widget.dart';
import 'package:flutter/material.dart';

class ListaGenerosFilmesWidget extends StatelessWidget {
  final int generoSelecionado;
  final Map<int, String> generosFilme;
  final void Function(int) onPressed;

  const ListaGenerosFilmesWidget({
    super.key,
    required this.generoSelecionado,
    required this.generosFilme,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final lista = generosFilme.entries.map((item) => item.value).toList();

    return SizedBox(
      height: DimensoesApp.larguraProporcional(35),
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: lista.length,
        separatorBuilder: (_, __) => const CustomSizedBoxWidget(width: 8),
        itemBuilder: (_, i) => GestureDetector(
          onTap: () => onPressed(i),
          child: Chip(
            backgroundColor:
                generoSelecionado == i ? AppTema.azul : AppTema.cinza,
            label: Text(lista[i]),
          ),
        ),
      ),
    );
  }
}
