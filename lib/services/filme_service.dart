import 'package:app_tmdb/services/custom_dio.dart';
import 'package:dio/dio.dart';

class FilmeService {
  final Dio _dio = CustomDio.baseDio;

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
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getGenerosFilmes() async {
    try {
      final response = await _dio.get('/genre/movie/list');

      return List.from(response.data['genres']);
    } catch (e) {
      rethrow;
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
      rethrow;
    }
  }

  Future getDetalhesFilmes(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId');

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future getElenco(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId/credits');

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future getFilmesSimilares(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId/similar');

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future getRecomendacoes(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId/recommendations');

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
