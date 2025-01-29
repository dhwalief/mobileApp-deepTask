// // filepath: /home/dhwalief/Development/mobileDevelopment/deeptask/lib/util/usage_stasts_util.dart
// import 'package:flutter/services.dart';

// class UsageStatsService {
//   static const MethodChannel _channel = MethodChannel('com.example.usageStats');

//   // Fungsi untuk memanggil native method "getUsageStats"
//   static Future<List<Map<String, dynamic>>> getUsageStats(
//       {bool filterSystemApps = true}) async {
//     try {
//       // Memanggil metode 'getUsageStats' di native Android
//       final List<dynamic> result =
//           await _channel.invokeMethod('getUsageStats', {
//         'filterSystemApps': filterSystemApps,
//       });
//       // Mengonversi hasil ke List<Map<String, dynamic>>
//       return result.map((e) => Map<String, dynamic>.from(e as Map)).toList();
//     } on PlatformException catch (e) {
//       // Tangani error jika terjadi
//       print('Error: ${e.message}');
//       return [];
//     }
//   }
// }
