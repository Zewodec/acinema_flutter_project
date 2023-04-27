import 'package:acinema_flutter_project/features/login/data/data_source/token_local_datasource.dart';
import 'package:dio/dio.dart';

class LoginRepository {
  const LoginRepository(this._dio);

  final Dio _dio;

  static const String _hostAPI = "https://fs-mt.qwerty123.tech";
  final String _sessionTokenURL = "$_hostAPI/api/auth/session";

  Future<void> _saveSessionTokenFromURL(Map<String, dynamic> data) async {
    final sessionToken = data['data']['sessionToken'];
    await TokenLocalDataSource.setSessionToken(sessionToken);
  }

  Future<String> dioGetSessionToken(var context) async {
    try {
      final response = await _dio.post(
        _sessionTokenURL,
      );

      if (response.statusCode == 200) {
        await _saveSessionTokenFromURL(response.data);
        return "OK";
      }
      return "Error Getting Session Token From API";
    } on DioError catch (e) {
      return "Error Getting Session Token From API\n${e.message}";
    }
  }
}
