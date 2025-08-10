import 'package:app_tmdb/models/filme_model.dart';
import 'package:app_tmdb/models/membro_elenco_model.dart';
import 'package:app_tmdb/services/filme_service.dart';
import 'package:flutter/material.dart';

class FilmesProvider extends ChangeNotifier {
  final FilmeService _filmeService = FilmeService();

  List<FilmeModel> _listaFilmes = [];
  List<FilmeModel> get listaFilmes => _listaFilmes;

  final Map<int, String> _generosFilmes = {};
  Map<int, String> get generosFilmes => _generosFilmes;

  int? totalPages;

  bool carregando = false;
  bool temErro = false;
  String mensagemErro = '';

  Future getFilmesPopulares(int page) async {
    try {
      _resetError();
      _setCarregando(true);

      if (page == 1 && _listaFilmes.isNotEmpty) _listaFilmes = [];

      final response = await _filmeService.getFilmesPopulares(page);
      totalPages = response['total_pages'];

      for (var i = 0; i < (response['results'] as List).length; i++) {
        final item = response['results'][i];

        _listaFilmes.add(FilmeModel.fromJson(item));
      }
    } catch (e) {
      _setErro(e.toString());
    } finally {
      _setCarregando(false);
    }

    notifyListeners();
  }

  Future getGenerosFilmes() async {
    try {
      _resetError();
      _setCarregando(true);

      final response = await _filmeService.getGenerosFilmes();

      for (var i = 0; i < response.length; i++) {
        final item = response[i];

        _generosFilmes.putIfAbsent(item['id'], () => item['name']);
      }
    } catch (e) {
      _setErro(e.toString());
    } finally {
      _setCarregando(false);
    }

    notifyListeners();
  }

  Future getDetalhesFilmes(int movieId) async {
    try {
      final response = await _filmeService.getDetalhesFilmes(movieId);

      return FilmeModel.fromJson(response);
    } catch (e) {
      _setErro(e.toString());
      rethrow;
    }
  }

  Future<({List<MembroElencoModel> cast, List<MembroElencoModel> crew})>
      getElenco(int movieId) async {
    try {
      final response = await _filmeService.getElenco(movieId);

      final cast = List.from(response['cast'])
          .map((item) => MembroElencoModel.fromJson(item))
          .toList();
      final crew = List.from(response['crew'])
          .map((item) => MembroElencoModel.fromJson(item))
          .toList();

      return (cast: cast, crew: crew);
    } catch (e) {
      rethrow;
    }
  }

  void _setCarregando(bool valor) => carregando = valor;

  void _setErro(String mensagem) {
    temErro = true;
    mensagemErro = mensagem;
  }

  void _resetError() {
    temErro = false;
    mensagemErro = '';
  }
}
