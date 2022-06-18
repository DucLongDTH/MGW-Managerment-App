import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:universal_platform/universal_platform.dart';

const appName = 'MGW Management';
const companyName = 'Mega World';
const baseUrl = 'https://mgw-backend-nestjs.herokuapp.com';
const baseUrlName = 'baseUrl';

Future<String?> getDeviceID() async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String? deviceID;
  // String? deviceName;
  // String? operatingSystem;
  // String? projectAppID;
  try {
    if (UniversalPlatform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      deviceID = build.androidId; //UUID for Android
      // deviceName = build.model;
      // operatingSystem = 'Android';
    } else if (UniversalPlatform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      deviceID = data.identifierForVendor; //UUID for iOS
      // deviceName = data.name;
      // operatingSystem = 'iOS';
    }
    return deviceID ?? '';
  } on PlatformException {
    return null;
  }
}
