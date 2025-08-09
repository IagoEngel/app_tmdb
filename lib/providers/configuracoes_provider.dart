import 'package:app_tmdb/models/configuracoes_model.dart';
import 'package:app_tmdb/services/configuracoes_service.dart';
import 'package:flutter/material.dart';

class ConfiguracoesProvider extends ChangeNotifier {
  final ConfiguracoesService _configuracoesService = ConfiguracoesService();

  ConfiguracoesModel? configuracoes;

  bool carregando = false;
  bool temErro = false;
  String mensagemErro = '';

  Future getConfiguracoes() async {
    try {
      _resetError();
      _setCarregando(true);

      final response = await _configuracoesService.getConfiguracoes();
      configuracoes = ConfiguracoesModel.fromJson(response);
    } catch (e) {
      _setErro(e.toString());
    } finally {
      _setCarregando(false);
    }

    notifyListeners();
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
