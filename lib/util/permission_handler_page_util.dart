import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UsageStatsService {
  static const MethodChannel _channel = MethodChannel('com.example.usageStats');

  // Fungsi untuk memanggil native method "getUsageStats"
  static Future<List<Map<String, dynamic>>> getUsageStats(
      {bool filterSystemApps = true}) async {
    try {
      // Memanggil metode 'getUsageStats' di native Android
      final List<dynamic> result =
          await _channel.invokeMethod('getUsageStats', {
        'filterSystemApps': filterSystemApps,
      });
      // Mengonversi hasil ke List<Map<String, dynamic>>
      return result.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } on PlatformException catch (e) {
      // Tangani error jika terjadi
      print('Error: ${e.message}');
      return [];
    }
  }
}

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
                  maxHeight: 200,
                  maxWidth: 400,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _fetchUsageStats,
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Text(
                        "Stat Permission",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: _fetchUsageStats,
                    //   style: ElevatedButton.styleFrom(
                    //       backgroundColor:
                    //           Theme.of(context).colorScheme.secondary,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //       )),
                    //   child: Text("Running background services"),
                    // ),
                    // ElevatedButton(
                    //   onPressed: _fetchUsageStats,
                    //   style: ElevatedButton.styleFrom(
                    //       backgroundColor:
                    //           Theme.of(context).colorScheme.secondary,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //       )),
                    //   child: Text("Battery Optimization Permission"),
                    // ),
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
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text("Request Permission",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w400)),
        )),
      ],
    );
  }
}
