import 'package:app_tmdb/domain/models/membro_elenco_model.dart';
import 'package:app_tmdb/screens/detalhes%20filme/widgets/info_card_widget.dart';
import 'package:app_tmdb/ui/core/widgets/custom_sized_box_widget.dart';
import 'package:flutter/material.dart';

class ElencoFilmeWidget extends StatelessWidget {
  final String titulo;
  final List<MembroElencoModel> elenco;
  final double height;

  const ElencoFilmeWidget({
    super.key,
    required this.titulo,
    required this.elenco,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (elenco.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          titulo,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          height: height,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: elenco.length,
            separatorBuilder: (_, __) => const CustomSizedBoxWidget(width: 8),
            itemBuilder: (_, i) {
              return InfoCardWidget(
                imagePath: elenco[i].profilePath,
                titulo: elenco[i].name,
                subTitulo:
                    "(${elenco[i].character.isNotEmpty ? elenco[i].character : elenco[i].job})",
              );
            },
          ),
        ),
      ],
    );
  }
}
