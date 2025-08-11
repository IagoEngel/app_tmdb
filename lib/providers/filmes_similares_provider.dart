import 'package:app_tmdb/domain/models/filme_model.dart';
import 'package:app_tmdb/repository/filme_repository.dart';
import 'package:flutter/material.dart';

class FilmesSimilaresProvider extends ChangeNotifier {
  final FilmeRepository _filmeService = FilmeRepository();

  List<FilmeModel> _listaFilmes = [];
  List<FilmeModel> get listaFilmes => _listaFilmes;

  bool carregando = false;
  bool temErro = false;
  String mensagemErro = '';

  void resetProvider() {
    _listaFilmes = [];
    carregando = false;
    _resetError();
  }

  Future getFilmesSimilares(int movieId) async {
    try {
      _resetError();
      _setCarregando(true);

      final response = await _filmeService.getFilmesSimilares(movieId);

      for (var i = 0; i < (response['results'] as List).length; i++) {
        final item = FilmeModel.fromJson(response['results'][i]);
        _listaFilmes.add(item);
      }
    } catch (e) {
      _setErro('Erro ao buscar filmes similares => $e');
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
