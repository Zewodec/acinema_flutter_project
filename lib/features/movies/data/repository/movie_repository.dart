import 'package:acinema_flutter_project/core/interceptors/accept_language_interseptor.dart';
import 'package:acinema_flutter_project/core/interceptors/authorization_interceptor.dart';
import 'package:dio/dio.dart';

class MovieRepository {
  MovieRepository(this._dio) {
    _dio.interceptors
      ..add(AcceptLanguageInterceptor())
      ..add(AuthInterceptor());
  }

  final Dio _dio;

  static const String _hostAPI = "https://fs-mt.qwerty123.tech";

  final String _moviesListURL = "$_hostAPI/api/movies";

  Future<Map<String, dynamic>> dioGetAllMovies() async {
    try {
      final response = await _dio.get(_moviesListURL);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      return {"error": "Error getting all movies:\n${e.message}"};
    }
    return {"error": "Unexpected error while getting all movies!"};
  }
}
