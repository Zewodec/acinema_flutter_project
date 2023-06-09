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
    DateTime dateTime = DateTime.now();
    try {
      final response = await _dio.get(
          "$_moviesListURL?date=${dateTime.year}-${dateTime.month}-${dateTime.day}");

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      return {"error": "Error getting all movies:\n${e.message}"};
    }
    return {"error": "Unexpected error while getting all movies!"};
  }

  Future<Map<String, dynamic>> dioGetMoviesByDateOrQuery(
      String? searchMovieDate, String searchMovieName) async {
    String moviesListWithDateParameterURL = _moviesListURL;
    if (searchMovieDate != null && searchMovieName.isNotEmpty) {
      moviesListWithDateParameterURL +=
          "?date=$searchMovieDate&query=$searchMovieName";
    } else if (searchMovieDate != null) {
      moviesListWithDateParameterURL += "?date=$searchMovieDate";
    } else if (searchMovieName.isNotEmpty) {
      moviesListWithDateParameterURL += "?query=$searchMovieName";
    }
    try {
      final response = await _dio.get(moviesListWithDateParameterURL);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      return {"error": "Error getting movies with parameters:\n${e.message}"};
    }
    return {"error": "Unexpected error while getting movies with parameters!"};
  }
}
