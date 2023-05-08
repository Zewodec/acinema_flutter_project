import 'dart:convert';

import 'package:acinema_flutter_project/features/login/data/data_source/token_local_datasource.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import '../data_source/device_info.dart';

class LoginRepository {
  const LoginRepository(this._dio);

  final Dio _dio;

  static const String _hostAPI = "https://fs-mt.qwerty123.tech";
  final String _sessionTokenURL = "$_hostAPI/api/auth/session";

  // SESSION TOKEN
  Future<void> _saveSessionTokenFromURL(Map<String, dynamic> data) async {
    final sessionToken = data['data']['sessionToken'];
    await TokenLocalDataSource.setSessionToken(sessionToken);
  }

  Future<String> dioGetSessionToken() async {
    if (await TokenLocalDataSource.isSavedSessionToken()) {
      return "Already Exist Session Token";
    }

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

  // SIGNATURE
  Future<String> _getSignature() async {
    String secretKey = "2jukqvNnhunHWMBRRVcZ9ZQ9";
    String? sessionToken = await TokenLocalDataSource.getSessionToken();

    if (sessionToken != null && sessionToken.isNotEmpty) {
      var encodeSignature = utf8.encode(sessionToken + secretKey);
      var signature = sha256.convert(encodeSignature);
      return signature.toString();
    }
    return "No Signature";
  }

  // DATA FOR Access Token
  Future<Map<String, dynamic>> get _loginForAccessToken async => {
        "sessionToken": await TokenLocalDataSource.getSessionToken(),
        "signature": await _getSignature(),
        "deviceId": await DeviceInfo.getId(),
      };

  // ACCESS TOKEN
  Future<void> _saveAccessTokenFromURL(Map<String, dynamic> data) async {
    final accessToken = data['data']['sessionToken'];
    await TokenLocalDataSource.setAccessToken(accessToken);
  }

  final String _accessTokenURL = "$_hostAPI/api/auth/token";

  Future<String?> dioGetAccessToken() async {
    if (await TokenLocalDataSource.isSavedAccessToken()) {
      return "Already Exist Access Token";
    }
    try {
      final response = await _dio.post(
        _accessTokenURL,
        data: await _loginForAccessToken,
      );

      if (response.statusCode == 200) {
        await _saveAccessTokenFromURL(response.data);
        return null;
      }
      return "Error: Problem in getting Access Token";
    } on DioError catch (e) {
      return e.response?.data['data']['error'] ?? e.message ?? "Error";
    }
  }
}
