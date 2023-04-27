import 'package:shared_preferences/shared_preferences.dart';

class LoginStorage {
  const LoginStorage._();

  static const String _sessionTokenKey = "_sessionToken";
  static const String _signatureKey = "_signature";
  static const String _deviceIdKey = "_deviceId";
  static const String _accessTokenKey = "_accessToken";

  static Future<void> setSessionToken(String sessionToken) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(_sessionTokenKey, sessionToken);
  }

  static Future<String?> getSessionToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_sessionTokenKey);
  }

  static Future<void> setSignature(String signature) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(_signatureKey, signature);
  }

  static Future<String?> getSignature() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_signatureKey);
  }

  static Future<void> setDeviceId(String deviceId) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(_deviceIdKey, deviceId);
  }

  static Future<String?> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_deviceIdKey);
  }

  static Future<void> setAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(_accessTokenKey, accessToken);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_accessTokenKey);
  }

  static Future<void> clearSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
