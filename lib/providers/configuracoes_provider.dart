import 'package:app_tmdb/models/configuracoes_model.dart';
import 'package:app_tmdb/services/configuracoes_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesProvider extends ChangeNotifier {
  final ConfiguracoesService _configuracoesService = ConfiguracoesService();

  ConfiguracoesModel? configuracoes;

  bool temaClaro = false;

  bool temErro = false;
  String mensagemErro = '';

  Future getConfiguracoes() async {
    try {
      _resetError();

      final prefs = await SharedPreferences.getInstance();
      temaClaro = prefs.getBool('temaClaro') ?? false;

      final response = await _configuracoesService.getConfiguracoes();
      configuracoes = ConfiguracoesModel.fromJson(response);
    } catch (e) {
      _setErro(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future setTema() async {
    final prefs = await SharedPreferences.getInstance();
    final prefsTemaClaro = !(prefs.getBool('temaClaro') ?? false);
    temaClaro = prefsTemaClaro;
    await prefs.setBool('temaClaro', prefsTemaClaro);

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
