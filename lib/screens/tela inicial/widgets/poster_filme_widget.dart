import 'package:app_tmdb/providers/configuracoes_provider.dart';
import 'package:app_tmdb/utils/app_tema.dart';
import 'package:app_tmdb/utils/dimensoes_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class PosterFilmeWidget extends StatefulWidget {
  final String posterPath;

  const PosterFilmeWidget({
    super.key,
    required this.posterPath,
  });

  @override
  State<PosterFilmeWidget> createState() => _PosterFilmeWidgetState();
}

class _PosterFilmeWidgetState extends State<PosterFilmeWidget> {
  late ConfiguracoesProvider _configuracoesProvider;

  final double _tamanho50 = DimensoesApp.larguraProporcional(50);
  final double _tamanho56 = DimensoesApp.larguraProporcional(56);

  bool _carregandoImagem = true;
  String fullPath = '';

  @override
  void initState() {
    super.initState();

    _configuracoesProvider = Provider.of(context, listen: false);

    final baseUrl = _configuracoesProvider.configuracoes!.images.baseUrl;
    final posterSize =
        _configuracoesProvider.configuracoes!.images.posterSizes[0];
    fullPath = baseUrl + posterSize + widget.posterPath;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await precacheImage(NetworkImage(fullPath), context);

      setState(() => _carregandoImagem = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_carregandoImagem) {
      return Shimmer.fromColors(
        baseColor: AppTema.cinzaClaro.withAlpha(100),
        highlightColor: AppTema.cinzaClaro.withAlpha(200),
        child: Container(
          width: _tamanho50,
          height: _tamanho56,
          color: AppTema.cinza,
        ),
      );
    }

    return SizedBox(
      width: _tamanho50,
      height: _tamanho56,
      child: Image.network(fullPath),
    );
  }
}
