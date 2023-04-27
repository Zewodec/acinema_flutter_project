import 'dart:convert';

import 'package:acinema_flutter_project/features/login/data/interceptors/login_interceptor.dart';
import 'package:acinema_flutter_project/features/login/data/models/device_info.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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

  Future<String> dioGetSessionToken(var context) async {
    try {
      final response = await _dio.post(
        _sessionTokenURL,
      );

      if (response.statusCode == 200) {
        await _saveSessionTokenFromURL(response.data);
        return "OK";
      }
      return "Error Getting Session Toket From API";
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Помилка при отриманні токену сесії.\n${e.response?.data ?? "Error"}',
            style:
                const TextStyle(fontFamily: "FixelText", color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 6),
        ),
      );
      return "Error Getting Session Toket From API";
    }
  }

  Future<String> _getSignature() async {
    String secretKey = "2jukqvNnhunHWMBRRVcZ9ZQ9";
    String? sessionToken = await LoginStorage.getSessionToken();

    if (sessionToken != null && sessionToken.isNotEmpty) {
      var encodeSignature = utf8.encode(sessionToken + secretKey);
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
    final accessToken = data['data']['sessionToken'];
    await LoginStorage.setAccessToken(accessToken);
  }

  final String _accessTokenURL = "$_hostAPI/api/auth/token";

  Future<String> dioGetAccessToken(var context) async {
    try {
      final response = await _dio.post(
        _accessTokenURL,
        data: await _loginForAccessToken,
      );

      if (response.statusCode == 200) {
        await _saveAccessTokenFromURL(response.data);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Успішна авторизація.',
                style: TextStyle(fontFamily: "FixelText", color: Colors.white)),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
        return "OK";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Помилка при авторизації.',
              style: TextStyle(fontFamily: "FixelText", color: Colors.white)),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );

      return "BAD";
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Помилка при авторизації.\n${e.response?.data ?? "Error"}',
            style:
                const TextStyle(fontFamily: "FixelText", color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 6),
        ),
      );
      return e.response?.data ?? "Error";
    }
  }
}
