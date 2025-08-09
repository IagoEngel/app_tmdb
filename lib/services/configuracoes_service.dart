import 'package:app_tmdb/services/custom_dio.dart';
import 'package:dio/dio.dart';

class ConfiguracoesService {
  final Dio _dio = CustomDio.baseDio;

  Future getConfiguracoes() async {
    try {
      final response = await _dio.get('/configuration');

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}