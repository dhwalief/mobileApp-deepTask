import 'package:deeptask/widgets/stats_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:deeptask/constant/app_color.dart';
import 'package:deeptask/screens/permission_handler_page.dart';
import 'package:deeptask/util/usage_stats_util.dart';
import 'package:deeptask/widgets/list_tile_widget.dart';

class StatPage extends StatefulWidget {
  const StatPage({super.key});

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  bool _isGranted = false;
  List<AppUsageData> _usageData = [];

  @override
  void initState() {
    super.initState();
    _checkPermissionStatus(); // Cek status izin saat halaman di-load
  }

  // Metode untuk memeriksa status izin
  Future<void> _checkPermissionStatus() async {
    final bool isGranted = await PermissionHandlerUtil.checkPermission();
    setState(() {
      _isGranted = isGranted;
    });

    // Jika izin belum diberikan, navigasi ke PermissionHandlerPage
    if (!isGranted) {
      _navigateToPermissionPage();
    } else {
      // Jika izin diberikan, ambil data penggunaan aplikasi
      _fetchUsageStats();
    }
  }

  // Metode untuk menavigasi ke PermissionHandlerPage
  void _navigateToPermissionPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => PermissionHandlerPage(),
        ),
      );
    });
  }

  // Metode untuk mengambil data penggunaan aplikasi
  Future<void> _fetchUsageStats() async {
    final List<dynamic> stats =
        await UsageStats.getUsageStats(true); // Ambil data dari UsageStats
    setState(() {
      _usageData = stats
          .map((data) {
            final packageName = data['packageName'] as String;
            final appName = _extractAppName(packageName); // Ambil nama aplikasi
            final usageTime = (data['totalTimeInForeground'] as int) ~/
                60000; // Konversi ke menit
            return AppUsageData(appName, usageTime);
          })
          .where(
              (data) => data.usageTime > 0) // Filter data dengan usageTime > 0
          .toList();
    });
  }

  // Future<void> _fetchUsageStatsDetail() async {
  //   final List<dynamic> stats = await UsageStats.getUsageStats(true);
  //   setState(() {
  //     _usageData = stats
  //         .map((data) {
  //           final packageName = data['packageName'] as String;
  //           final appName = _extractAppName(packageName);
  //           final usageTime = (data['totalTimeInForeground'] as int) ~/ 60000;
  //           final iconBase64 =
  //               data['appIcon'] as String? ?? ""; // Tambahkan ikon

  //           return AppUsageDataTile(appName, usageTime, iconBase64);
  //         })
  //         .where((data) => data.usageTime > 0)
  //         .toList();
  //   });
  // }

  // Metode untuk mengambil nama aplikasi setelah titik terakhir atau underscore terakhir
  String _extractAppName(String packageName) {
    // Cari indeks terakhir dari titik (.) atau underscore (_)
    final lastDotIndex = packageName.lastIndexOf('.');
    final lastUnderscoreIndex = packageName.lastIndexOf('_');

    // Tentukan indeks terakhir yang valid
    final lastSeparatorIndex = (lastDotIndex > lastUnderscoreIndex)
        ? lastDotIndex
        : lastUnderscoreIndex;

    // Jika ditemukan titik atau underscore, ambil substring setelahnya
    if (lastSeparatorIndex != -1) {
      return packageName.substring(lastSeparatorIndex + 1);
    }

    // Jika tidak ada titik atau underscore, kembalikan nama asli
    return packageName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.surface,
      body: _isGranted
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Data Penggunaan Aplikasi",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColor.onSurface,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 300,
                    child: _usageData.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : UsageStatsChart(
                            usageData: _usageData,
                            title: 'Penggunaan Harian',
                            yText: 'waktu',
                          ), // Gunakan widget grafik
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(), // Tampilkan loading indicator
            ),
    );
  }
}
