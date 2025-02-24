// import 'package:flutter/material.dart';
// import 'package:deeptask/models/app_usage_data.dart'; // Impor AppUsageData

// class UsageStatsList extends StatelessWidget {
//   final List<AppUsageData> usageData;

//   const UsageStatsList({super.key, required this.usageData});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: usageData.length,
//       itemBuilder: (context, index) {
//         final data = usageData[index];
//         return ListTile(
//           leading: data.appIcon != null
//               ? Image.memory(
//                   data.appIcon!,
//                   width: 40,
//                   height: 40,
//                 )
//               : Icon(Icons.android, size: 40),
//           title: Text(data.packageName),
//           subtitle: Text(_formatDuration(data.usageTime)),
//         );
//       },
//     );
//   }

//   // Format durasi ke menit atau jam
//   String _formatDuration(int usageTime) {
//     if (usageTime >= 60) {
//       final hours = usageTime ~/ 60;
//       final minutes = usageTime % 60;
//       return "$hours jam $minutes menit";
//     } else {
//       return "$usageTime menit";
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';

class AppUsageDataTile {
  final String appName;
  final int usageTime;
  final String? iconBase64;

  AppUsageDataTile(this.appName, this.usageTime, this.iconBase64);
}

class AppUsageTile extends StatelessWidget {
  final AppUsageDataTile appData;

  const AppUsageTile({super.key, required this.appData});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildAppIcon(),
      title: Text(appData.appName),
      subtitle: Text(
        "${appData.usageTime ~/ 60} jam ${appData.usageTime % 60} menit",
        style: TextStyle(color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildAppIcon() {
    if (appData.iconBase64 != null && appData.iconBase64!.isNotEmpty) {
      try {
        final decodedBytes = base64Decode(appData.iconBase64!);
        return Image.memory(decodedBytes, width: 40, height: 40);
      } catch (e) {
        return Icon(Icons.apps, size: 40);
      }
    }
    return Icon(Icons.apps, size: 40);
  }
}
