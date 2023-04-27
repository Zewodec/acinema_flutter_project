import 'dart:convert';

import 'package:acinema_flutter_project/features/login/data/interceptors/login_interceptor.dart';
import 'package:acinema_flutter_project/features/login/data/models/device_info.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import 'login_storage.dart';

class LoginAPI {
  static const String _hostAPI = "https://fs-mt.qwerty123.tech";

  late final Dio _dio;

  LoginAPI() {
    _dio = Dio();
    _dio.interceptors.add(LoginInterceptor());
  }

  final String _sessionTokenURL = "$_hostAPI/api/auth/session";

  Future<void> _saveSessionTokenFromURL(Map<String, dynamic> data) async {
    final sessionToken = data['data']['sessionToken'];
    await LoginStorage.setSessionToken(sessionToken);
  }

  Future<bool> _dioGetSessionToken() async {
    final response = await _dio.post(
      _sessionTokenURL,
    );

    if (response.statusCode == 200) {
      await _saveSessionTokenFromURL(response.data);
      return true;
    }
    return false;
  }

  Future<String> _getSignature() async {
    String secretKey = "2jukqvNnhunHWMBRRVcZ9ZQ9";
    String? sessionToken = await LoginStorage.getSessionToken();

    if (sessionToken != null && sessionToken.isNotEmpty) {
      var encodeSignature = utf8.encode(secretKey + sessionToken);
      var signature = sha256.convert(encodeSignature);
      return signature.toString();
    }
    return "No Signature";
  }

  Future<Map<String, dynamic>> get _loginForAccessToken async => {
        "sessionToken": await LoginStorage.getSessionToken(),
        "signature": await _getSignature(),
        "deviceId": await DeviceInfo.getId(),
      };

  Future<void> _saveAccessTokenFromURL(Map<String, dynamic> data) async {
    final accessToken = data['data']['accessToken'];
    await LoginStorage.setAccessToken(accessToken);
  }

  final String _accessTokenURL = "$_hostAPI/api/auth/token";

  Future<bool> dioGetAccessToken() async {
    _dioGetSessionToken;
    final response = await _dio.post(
      _accessTokenURL,
      data: _loginForAccessToken,
    );

    if (response.statusCode == 200) {
      await _saveAccessTokenFromURL(response.data);
      return true;
    }
    return false;
  }
}
