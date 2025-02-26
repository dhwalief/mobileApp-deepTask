// lib/services/usage_stats_service.dart
import 'package:deeptask/data/app_usage_data.dart';
import 'package:deeptask/util/usage_stats_util.dart';

class UsageStatsService {
  Future<List<AppUsageData>> fetchUsageStats() async {
    final List<dynamic> stats = await UsageStats.getUsageStats(false);
    if (stats.isEmpty) {
      print("No usage stats data received.");
      return [];
    }

    final List<AppUsageData> usageData = stats
        .map((data) {
          final packageName = data['packageName'] as String;
          final appName = _extractAppName(packageName);
          final usageTime = (data['totalTimeInForeground'] as int) ~/ 60000;
          final iconBase64 = data['appIcon'] as String? ?? "";
          return AppUsageData(appName, usageTime, iconBase64);
        })
        .where((data) => data.usageTime > 0)
        .toList();

    if (usageData.isEmpty) {
      print("Mapped usage data is empty.");
    } else {
      print("Mapped usage data: $usageData");
    }

    return usageData;
  }

  String _extractAppName(String packageName) {
    final lastDotIndex = packageName.lastIndexOf('.');
    final lastUnderscoreIndex = packageName.lastIndexOf('_');
    final lastSeparatorIndex = (lastDotIndex > lastUnderscoreIndex)
        ? lastDotIndex
        : lastUnderscoreIndex;
    return (lastSeparatorIndex != -1)
        ? packageName.substring(lastSeparatorIndex + 1)
        : packageName;
  }
}
