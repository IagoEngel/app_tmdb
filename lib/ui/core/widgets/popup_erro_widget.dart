import 'package:app_tmdb/ui/core/themes/app_tema.dart';
import 'package:flutter/material.dart';

class PopupErroWidget extends StatelessWidget {
  final String titulo;
  final String mensagem;

  const PopupErroWidget({
    super.key,
    this.titulo = 'Um erro inesperado ocorreu',
    required this.mensagem,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTema.cinza,
      title: Text(
        titulo,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Text(
        mensagem,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
