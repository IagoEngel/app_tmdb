import 'package:app_tmdb/models/filme_model.dart';
import 'package:app_tmdb/services/filme_service.dart';
import 'package:flutter/material.dart';

class BuscaFilmesProvider extends ChangeNotifier {
  final FilmeService _filmeService = FilmeService();

  List<FilmeModel> _listaFilmesBuscados = [];
  List<FilmeModel> get listaFilmesBuscados => _listaFilmesBuscados;

  int? totalPages;

  bool carregando = false;
  bool temErro = false;
  String mensagemErro = '';

  Future buscarFilmes(int page, String query, {int generoId = 0}) async {
    try {
      _resetError();
      _setCarregando(true);

      if (query.isEmpty) {
        return;
      }

      if (page == 1 && _listaFilmesBuscados.isNotEmpty) {
        _listaFilmesBuscados = [];
      }

      if (totalPages != null && page >= totalPages!) {
        return;
      }

      final response = await _filmeService.buscarFilmes(page, query);
      totalPages = response['total_pages'];

      for (var i = 0; i < (response['results'] as List).length; i++) {
        final item = FilmeModel.fromJson(response['results'][i]);

        if (generoId != 0 && !item.genreIds.contains(generoId)) continue;
        _listaFilmesBuscados.add(item);
      }
    } catch (e) {
      _setErro('Erro ao buscar filmes => $e');
    } finally {
      _setCarregando(false);
    }
  }

  void _setCarregando(bool valor) {
    carregando = valor;
    notifyListeners();
  }

  void _setErro(String mensagem) {
    temErro = true;
    mensagemErro = mensagem;
  }

  void _resetError() {
    temErro = false;
    mensagemErro = '';
  }
}
