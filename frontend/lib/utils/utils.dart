import 'package:device_info_plus/device_info_plus.dart';
import 'dart:math'; // For generating a fallback unique ID
import 'package:flutter/foundation.dart'; // For kIsWeb

Future<String> getDeviceId() async {
  final deviceInfo = DeviceInfoPlugin();

  if (kIsWeb) {
    // Web-specific logic
    final webInfo = await deviceInfo.webBrowserInfo;
    return "${webInfo.vendor}-${webInfo.userAgent}-${webInfo.hardwareConcurrency}";
  } else if (defaultTargetPlatform == TargetPlatform.android) {
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    final iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor ?? "unknown_device_id";
  } else {
    return "unsupported_device";
  }
}
