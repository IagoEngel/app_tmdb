import 'package:app_tmdb/view%20model/configuracoes_view_model.dart';
import 'package:app_tmdb/ui/core/themes/app_tema.dart';
import 'package:app_tmdb/utils/dimensoes_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImagemWidget extends StatefulWidget {
  final String imagePath;
  final double width;
  final double height;
  final double radius;
  final String tipoImagem;

  const ShimmerImagemWidget({
    super.key,
    required this.imagePath,
    this.width = 50,
    this.height = 56,
    this.radius = 8,
    this.tipoImagem = 'poster',
  });

  @override
  State<ShimmerImagemWidget> createState() => _ShimmerImagemWidgetState();
}

class _ShimmerImagemWidgetState extends State<ShimmerImagemWidget> {
  late ConfiguracoesViewModel _configuracoesProvider;

  bool _carregandoImagem = true;
  String fullPath = '';

  @override
  void initState() {
    super.initState();

    _configuracoesProvider = Provider.of(context, listen: false);

    final baseUrl = _configuracoesProvider.configuracoes!.images.baseUrl;
    final posterSize = (widget.tipoImagem == 'poster'
        ? _configuracoesProvider.configuracoes!.images.posterSizes[0]
        : widget.tipoImagem == 'profile'
            ? _configuracoesProvider.configuracoes!.images.profileSizes[1]
            : _configuracoesProvider.configuracoes!.images.backdropSizes[1]);
    fullPath = baseUrl + posterSize + widget.imagePath;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.imagePath.isNotEmpty) {
        await precacheImage(NetworkImage(fullPath), context);
      }

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

    if (widget.imagePath.isEmpty) {
      return SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              color: AppTema.corIcone,
              size: DimensoesApp.larguraProporcional(40),
            ),
            Text(
              'Não há imagem',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
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
