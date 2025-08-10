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
}
