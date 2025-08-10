import 'package:app_tmdb/screens/home/home_screen.dart';
import 'package:app_tmdb/screens/pesquisa/pesquisa_screen.dart';
import 'package:app_tmdb/utils/dimensoes_app.dart';
import 'package:app_tmdb/utils/widgets/floating_navigation_bar_widget.dart';
import 'package:flutter/material.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final List<Widget> _listaTelas = [
    const HomeScreen(),
    const PesquisaScreen(),
  ];
  final double _tamanho16 = DimensoesApp.larguraProporcional(16);
  final double _tamanho24 = DimensoesApp.larguraProporcional(24);

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(_tamanho16, _tamanho24, _tamanho16, 0),
          child: _listaTelas[selectedIndex],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingNavigationBarWidget(
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) => setState(() => selectedIndex = value),
      ),
    );
  }
}
