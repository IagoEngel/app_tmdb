import 'package:app_tmdb/view%20model/busca_filmes_view_model.dart';
import 'package:app_tmdb/view%20model/configuracoes_view_model.dart';
import 'package:app_tmdb/view%20model/filmes_provider_view_model.dart';
import 'package:app_tmdb/view%20model/filmes_similares_view_model.dart';
import 'package:app_tmdb/view%20model/recomendacoes_view_model.dart';
import 'package:app_tmdb/screens/tela%20inicial/tela_inicial_screen.dart';
import 'package:app_tmdb/ui/core/themes/app_tema.dart';
import 'package:app_tmdb/utils/dimensoes_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBase extends StatelessWidget {
  const AppBase({super.key});

  @override
  Widget build(BuildContext context) {
    DimensoesApp(MediaQuery.of(context));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConfiguracoesViewModel()),
        ChangeNotifierProvider(create: (_) => FilmesViewModel()),
        ChangeNotifierProvider(create: (_) => BuscaFilmesViewModel()),
        ChangeNotifierProvider(create: (_) => FilmesSimilaresViewModel()),
        ChangeNotifierProvider(create: (_) => RecomendacoesViewModel()),
      ],
      child: Consumer<ConfiguracoesViewModel>(
        child: const TelaInicial(),
        builder: (_, configuracoes, child) => MaterialApp(
          theme: configuracoes.temaClaro
              ? AppTema.temaBaseClaro()
              : AppTema.temaBaseEscuro(),
          home: child,
        ),
      ),
    );
  }
}
