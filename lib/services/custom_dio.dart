import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class CustomDio {
  static Dio get baseDio => Dio(
        BaseOptions(
          baseUrl: 'https://api.themoviedb.org/3',
          headers: {
            'Authorization': 'Bearer ${dotenv.env['API_READ_ACCESS_TOKEN']}',
          },
          queryParameters: {
            'language': 'pt-BR',
          },
        ),
      );
}
