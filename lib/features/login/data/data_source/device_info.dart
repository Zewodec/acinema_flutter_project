import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  /// *
  /// Returns unique Android Device ID
  static Future<String> getId() async {
    try {
      var deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        var androidDeviceInfo = await deviceInfo.androidInfo;
        return androidDeviceInfo.id /*.hashCode*/;
      }
    } catch (error) {
      return "ErrorID";
    }
    return "ErrorID2";
  }
}
