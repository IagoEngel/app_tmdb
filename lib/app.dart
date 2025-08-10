import 'package:app_tmdb/providers/busca_filmes_provider.dart';
import 'package:app_tmdb/providers/configuracoes_provider.dart';
import 'package:app_tmdb/providers/filmes_provider.dart';
import 'package:app_tmdb/providers/filmes_similares_provider.dart';
import 'package:app_tmdb/providers/recomendacoes_provider.dart';
import 'package:app_tmdb/screens/tela%20inicial/tela_inicial_screen.dart';
import 'package:app_tmdb/utils/app_tema.dart';
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
        ChangeNotifierProvider(create: (_) => ConfiguracoesProvider()),
        ChangeNotifierProvider(create: (_) => FilmesProvider()),
        ChangeNotifierProvider(create: (_) => BuscaFilmesProvider()),
        ChangeNotifierProvider(create: (_) => FilmesSimilaresProvider()),
        ChangeNotifierProvider(create: (_) => RecomendacoesProvider()),
      ],
      child: Consumer<ConfiguracoesProvider>(
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
