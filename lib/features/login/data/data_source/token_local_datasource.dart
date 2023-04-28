import 'package:shared_preferences/shared_preferences.dart';

class TokenLocalDataSource {
  TokenLocalDataSource._();

  static const String _sessionTokenKey = "_sessionToken";
  static const String _signatureKey = "_signature";
  static const String _deviceIdKey = "_deviceId";
  static const String _accessTokenKey = "_accessToken";

  static Future<void> setSessionToken(String sessionToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_sessionTokenKey, sessionToken);
  }

  static Future<String?> getSessionToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_sessionTokenKey);
  }

  static Future<bool> isSavedSessionToken() async {
    return await TokenLocalDataSource.getSessionToken() != null &&
        await TokenLocalDataSource.getSessionToken() != "";
  }

  static Future<void> setSignature(String signature) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_signatureKey, signature);
  }

  static Future<String?> getSignature() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_signatureKey);
  }

  static Future<bool> isSavedSignature() async {
    return await TokenLocalDataSource.getSignature() != null &&
        await TokenLocalDataSource.getSignature() != "";
  }

  static Future<void> setDeviceId(String deviceId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_deviceIdKey, deviceId);
  }

  static Future<String?> getDeviceId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_deviceIdKey);
  }

  static Future<bool> isSavedDeviceId() async {
    return await TokenLocalDataSource.getDeviceId() != null &&
        await TokenLocalDataSource.getDeviceId() != "";
  }

  static Future<void> setAccessToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_accessTokenKey, accessToken);
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_accessTokenKey);
  }

  static Future<bool> isSavedAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.containsKey(_accessTokenKey);
  }

  static Future<void> clearSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear();
  }
}
