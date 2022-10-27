import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoApi {
  static final _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<String> getPhoneInfo() async {
    if (Platform.isAndroid){
      final info = await _deviceInfoPlugin.androidInfo;
      return "${info.manufacturer} - ${info.model}";
    }
    else if (Platform.isIOS){
      final info = await _deviceInfoPlugin.iosInfo;
      return "${info.name} ${info.model}";
    }
    else {
      throw UnimplementedError();
    }
  }
}