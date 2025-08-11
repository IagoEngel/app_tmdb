import 'package:app_tmdb/repository/custom_dio_repository.dart';
import 'package:dio/dio.dart';

class FilmeRepository {
  final Dio _dio = CustomDioRepository.baseDio;

  Future getFilmesPopulares(int page) async {
    try {
      final response = await _dio.get(
        '/movie/popular',
        queryParameters: {
          'page': page,
        },
      );

      return response.data;
    } catch (e) {
      String error = e is DioException ? e.message ?? '' : e.toString();
      throw Exception(error);
    }
  }

  Future<List<Map<String, dynamic>>> getGenerosFilmes() async {
    try {
      final response = await _dio.get('/genre/movie/list');

      return List.from(response.data['genres']);
    } catch (e) {
      String error = e is DioException ? e.message ?? '' : e.toString();
      throw Exception(error);
    }
  }

  Future buscarFilmes(int page, String query) async {
    try {
      final response = await _dio.get(
        '/search/movie',
        queryParameters: {
          'page': page,
          'query': query,
        },
      );

      return response.data;
    } catch (e) {
      String error = e is DioException ? e.message ?? '' : e.toString();
      throw Exception(error);
    }
  }

  Future getDetalhesFilmes(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId');

      return response.data;
    } catch (e) {
      String error = e is DioException ? e.message ?? '' : e.toString();
      throw Exception(error);
    }
  }

  Future getElenco(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId/credits');

      return response.data;
    } catch (e) {
      String error = e is DioException ? e.message ?? '' : e.toString();
      throw Exception(error);
    }
  }

  Future getFilmesSimilares(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId/similar');

      return response.data;
    } catch (e) {
      String error = e is DioException ? e.message ?? '' : e.toString();
      throw Exception(error);
    }
  }

  Future getRecomendacoes(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId/recommendations');

      return response.data;
    } catch (e) {
      String error = e is DioException ? e.message ?? '' : e.toString();
      throw Exception(error);
    }
  }
}
