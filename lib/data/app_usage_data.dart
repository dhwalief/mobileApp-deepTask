// lib/data/app_usage_data.dart
class AppUsageData {
  final String packageName;
  final int usageTime;
  final String? iconBase64;

  AppUsageData(this.packageName, this.usageTime, [this.iconBase64]);
}
