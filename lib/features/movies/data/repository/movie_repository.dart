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

  Future<Map<String, dynamic>> dioGetMoviesBySearch(
      String searchMovieName) async {
    String moviesListWithSearchParameterURL =
        "$_moviesListURL?query=$searchMovieName";
    try {
      final response = await _dio.get(moviesListWithSearchParameterURL);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      return {"error": "Error getting movies with search:\n${e.message}"};
    }
    return {
      "error": "Unexpected error while getting movies with search parameter!"
    };
  }

  Future<Map<String, dynamic>> dioGetMoviesByDate(
      String searchMovieDate) async {
    String moviesListWithDateParameterURL =
        "$_moviesListURL?date=$searchMovieDate";
    try {
      final response = await _dio.get(moviesListWithDateParameterURL);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      return {"error": "Error getting movies by date:\n${e.message}"};
    }
    return {
      "error": "Unexpected error while getting movies with date parameter!"
    };
  }
}
