import 'package:app_tmdb/providers/configuracoes_provider.dart';
import 'package:app_tmdb/utils/app_tema.dart';
import 'package:app_tmdb/utils/dimensoes_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class PosterFilmeWidget extends StatefulWidget {
  final String posterPath;
  final double width;
  final double height;
  final double radius;

  const PosterFilmeWidget({
    super.key,
    required this.posterPath,
    this.width = 50,
    this.height = 56,
    this.radius = 8,
  });

  @override
  State<PosterFilmeWidget> createState() => _PosterFilmeWidgetState();
}

class _PosterFilmeWidgetState extends State<PosterFilmeWidget> {
  late ConfiguracoesProvider _configuracoesProvider;

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
    final double width = DimensoesApp.larguraProporcional(widget.width);
    final double height = DimensoesApp.larguraProporcional(widget.height);
    final double radius = DimensoesApp.larguraProporcional(widget.radius);

    if (_carregandoImagem) {
      return Shimmer.fromColors(
        baseColor: AppTema.cinzaClaro.withAlpha(100),
        highlightColor: AppTema.cinzaClaro.withAlpha(200),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppTema.cinza,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.network(
          fullPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
