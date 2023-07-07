import 'package:dio/dio.dart';

import '../../../../core/interceptors/accept_language_interseptor.dart';
import '../../../../core/interceptors/authorization_interceptor.dart';

class TicketsRepository {
  TicketsRepository(this._dio) {
    _dio.interceptors
      ..add(AcceptLanguageInterceptor())
      ..add(AuthInterceptor());
  }

  final Dio _dio;

  static const String _hostAPI = "https://fs-mt.qwerty123.tech";

  final String _ticketsListURL = "$_hostAPI/api/user/tickets";

  Future<Map<String, dynamic>> dioGetUserTickets() async {
    try {
      final response = await _dio.get(_ticketsListURL);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      return {"error": "Error getting all movies:\n${e.message}"};
    }
    return {"error": "Unexpected error while getting all movies!"};
  }
}
