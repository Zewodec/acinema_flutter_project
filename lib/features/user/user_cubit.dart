import 'package:acinema_flutter_project/features/user/user_model.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../core/interceptors/accept_language_interseptor.dart';
import '../../core/interceptors/authorization_interceptor.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void loadUserInfo() async {
    emit(UserLoading());
    final userData = await _dioGetUser();
    final user = UserModelImpl.fromJson(userData);
    emit(UserLoaded(user.data));
  }

  Future<Map<String, dynamic>> _dioGetUser() async {
    Dio dio = Dio();
    dio.interceptors
      ..add(AcceptLanguageInterceptor())
      ..add(AuthInterceptor());

    const String hostAPI = "https://fs-mt.qwerty123.tech";

    const String userApiURL = "$hostAPI/api/user";

    try {
      final response = await dio.get(userApiURL);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      return {"error": "Error getting all movies:\n${e.message}"};
    }
    return {"error": "Unexpected error while getting all movies!"};
  }
}
