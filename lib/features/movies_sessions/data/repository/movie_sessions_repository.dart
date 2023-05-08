import 'package:acinema_flutter_project/core/interceptors/accept_language_interseptor.dart';
import 'package:acinema_flutter_project/core/interceptors/authorization_interceptor.dart';
import 'package:dio/dio.dart';

class MovieSessionsRepository {
  MovieSessionsRepository(this._dio) {
    _dio.interceptors
      ..add(AcceptLanguageInterceptor())
      ..add(AuthInterceptor());
  }

  final Dio _dio;

  static const String _hostAPI = "https://fs-mt.qwerty123.tech";

  final String _sessionsListURL = "$_hostAPI/api/sessions";

  Future<Map<String, dynamic>> dioGetSessions(
      String movieId, String date) async {
    String sessionsListWithParametersURL =
        "$_sessionsListURL?movieId=$movieId&date=$date";
    try {
      final response = await _dio.get(sessionsListWithParametersURL);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      return {"error": "Error getting sessions with parameters:\n${e.message}"};
    }
    return {
      "error": "Unexpected error while getting sessions with parameters!"
    };
  }
}
