// lib/util/usage_stats_util.dart
import 'package:flutter/services.dart';

class PermissionHandlerUtil {
  static const MethodChannel _channel = MethodChannel('com.example.usageStats');

  static Future<bool> checkPermission() async {
    try {
      final bool hasPermission = await _channel.invokeMethod('checkPermission');
      return hasPermission;
    } on PlatformException catch (e) {
      print("Failed to check permission: ${e.message}");
      return false;
    }
  }

  static Future<void> openUsageAccessSettings() async {
    try {
      await _channel.invokeMethod('openUsageAccessSettings');
    } on PlatformException catch (e) {
      print("Failed to open settings: ${e.message}");
    }
  }
}

class UsageStats {
  static const MethodChannel _channel = MethodChannel('com.example.usageStats');

  static Future<List<dynamic>> getUsageStats(bool filterSystemApps) async {
    try {
      final List<dynamic> result = await _channel.invokeMethod(
        'getUsageStats',
        {'filterSystemApps': filterSystemApps},
      );
      return result;
    } on PlatformException catch (e) {
      print("Failed to get usage stats: ${e.message}");
      return [];
    }
  }
}
