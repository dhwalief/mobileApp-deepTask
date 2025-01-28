import 'package:deeptask/util/usage_stasts_util.dart';
import 'package:flutter/material.dart';
// import 'package:de';
// import 'package:usage_stats_new/usage_stats.dart';

// class PermissionHandlerUtil {
//   static Future<bool> checkPermission() async {
//     return await Permission.camera.isGranted &&
//         await Permission.microphone.isGranted &&
//         await Permission.storage.isGranted;
//   }

//   Future<void> checkUsagePermission() async {
//     bool? hasPermission = await UsageStats.checkUsagePermission();
//     if (hasPermission == true) {
//       print("Izin sudah diberikan.");
//     } else {
//       print("Izin belum diberikan.");
//       UsageStats.grantUsagePermission();
//     }
//   }
// }

class PermissionHandlerUtil extends StatefulWidget {
  const PermissionHandlerUtil({super.key});

  @override
  State<PermissionHandlerUtil> createState() => _PermissionHandlerUtilState();
}

class _PermissionHandlerUtilState extends State<PermissionHandlerUtil> {
  List<Map<String, dynamic>> _usageStats = [];
  final bool _filterSystemApps = true;

  @override
  void initState() {
    super.initState();
    // _fetchUsageStats();
  }

  Future<void> _fetchUsageStats() async {
    // Mendapatkan data stats dari service
    final stats = await UsageStatsService.getUsageStats(
        filterSystemApps: _filterSystemApps);

    // Menggunakan cast eksplisit untuk mengonversi ke List<Map<String, dynamic>>
    setState(() {
      _usageStats = List<Map<String, dynamic>>.from(
          stats.map((e) => Map<String, dynamic>.from(e)));
    });
  }

  void dialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(10),
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 300,
                  maxWidth: 500,
                ),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: _fetchUsageStats,
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Text("Stat Permission"),
                    ),
                    ElevatedButton(
                      onPressed: _fetchUsageStats,
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Text("Running background services"),
                    ),
                    ElevatedButton(
                      onPressed: _fetchUsageStats,
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Text("Battery Optimization Permission"),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "You need to request permission to access the feature",
          textAlign: TextAlign.center,
        ),
        Center(
            child: ElevatedButton(
          onPressed: dialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text("Request Permission"),
        )),
      ],
    );
  }
}
