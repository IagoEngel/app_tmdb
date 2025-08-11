import 'package:app_tmdb/view%20model/configuracoes_view_model.dart';
import 'package:app_tmdb/ui/core/themes/app_tema.dart';
import 'package:app_tmdb/utils/dimensoes_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FloatingNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onDestinationSelected;

  const FloatingNavigationBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final double tamanho24 = DimensoesApp.larguraProporcional(24);
    final double tamanho50 = DimensoesApp.larguraProporcional(50);
    final double tamanho60 = DimensoesApp.larguraProporcional(60);

    return Consumer<ConfiguracoesViewModel>(
      builder: (context, _, __) => Container(
        height: DimensoesApp.larguraProporcional(58),
        width: DimensoesApp.larguraProporcional(130),
        padding: EdgeInsets.all(DimensoesApp.larguraProporcional(4)),
        decoration: BoxDecoration(
          color: AppTema.corFloatingNav,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => onDestinationSelected(0),
              child: Container(
                width: tamanho60,
                height: tamanho50,
                decoration: BoxDecoration(
                  color: selectedIndex == 0
                      ? AppTema.destaque
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/home.svg',
                    width: tamanho24,
                    height: tamanho24,
                    color: AppTema.corIcone,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => onDestinationSelected(1),
              child: Container(
                width: tamanho60,
                height: tamanho50,
                decoration: BoxDecoration(
                  color: selectedIndex == 1
                      ? AppTema.destaque
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/busca.svg',
                    width: tamanho24,
                    height: tamanho24,
                    color: AppTema.corIcone,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
