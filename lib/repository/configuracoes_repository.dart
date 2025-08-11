import 'package:app_tmdb/repository/custom_dio_repository.dart';
import 'package:dio/dio.dart';

class ConfiguracoesRepository {
  final Dio _dio = CustomDioRepository.baseDio;

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