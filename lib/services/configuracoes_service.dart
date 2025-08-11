import 'package:app_tmdb/services/custom_dio.dart';
import 'package:dio/dio.dart';

class ConfiguracoesService {
  final Dio _dio = CustomDio.baseDio;

  Future getConfiguracoes() async {
    try {
      final response = await _dio.get('/configuration');

      return response.data;
    } catch (e) {
      String error = e is DioException ? e.message ?? '' : e.toString();
      throw Exception(error);
    }
  }
}