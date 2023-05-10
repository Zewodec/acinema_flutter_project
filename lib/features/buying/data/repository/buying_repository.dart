import 'package:acinema_flutter_project/core/interceptors/accept_language_interseptor.dart';
import 'package:acinema_flutter_project/core/interceptors/authorization_interceptor.dart';
import 'package:dio/dio.dart';

import '../../../movies_sessions/data/models/movie_sessions.dart';

class BuyingRepository {
  BuyingRepository(this._dio) {
    _dio.interceptors
      ..add(AcceptLanguageInterceptor())
      ..add(AuthInterceptor());
  }

  final Dio _dio;

  static const String _hostAPI = "https://fs-mt.qwerty123.tech";

  final String _bookURL = "$_hostAPI/api/movies/book";

  Future<Map<String, dynamic>> dioBookSeats(
      List<Seat> seats, int sessionId) async {
    List<int> seatsIds = [];
    for (Seat seat in seats) {
      seatsIds.add(seat.id);
    }
    Map<String, dynamic> bookData = {
      "seats": seatsIds,
      "sessionId": sessionId,
    };
    try {
      final response = await _dio.post(_bookURL, data: bookData);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      return {"error": "Error post book:\n${e.message}"};
    }
    return {"error": "Unexpected error while booking!"};
  }

  final String _buyURL = "$_hostAPI/api/movies/buy";

  Future<Map<String, dynamic>> dioBuySeats(List<int> seats, int sessionId,
      String email, String cardNumber, String exprationDate, String cvv) async {
    Map<String, dynamic> buyData = {
      "seats": seats,
      "sessionId": sessionId,
      "email": email,
      "cardNumber": cardNumber,
      "expirationDate": exprationDate,
      "cvv": cvv
    };
    try {
      final response = await _dio.post(_buyURL, data: buyData);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      return {"error": "Error buy:\n${e.message}"};
    }
    return {"error": "Unexpected error while buying!"};
  }
}
