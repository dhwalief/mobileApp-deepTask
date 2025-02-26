// lib/screens/stat_page.dart
import 'package:deeptask/data/app_usage_data.dart';
import 'package:deeptask/services/permission_handler_service.dart';
import 'package:deeptask/services/usage_stats_service.dart';
import 'package:deeptask/widgets/stats_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:deeptask/constant/app_color.dart';
import 'package:deeptask/screens/permission_handler_page.dart';
import 'dart:convert'; // Untuk decode base64

class StatPage extends StatefulWidget {
  const StatPage({super.key});

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  bool _isGranted = false;
  List<AppUsageData> _usageData = [];
  final PermissionHandlerService _permissionHandlerService =
      PermissionHandlerService();
  final UsageStatsService _usageStatsService = UsageStatsService();

  @override
  void initState() {
    super.initState();
    _checkPermissionStatus();
  }

  Future<void> _checkPermissionStatus() async {
    final bool isGranted =
        await _permissionHandlerService.checkPermissionStatus();
    setState(() {
      _isGranted = isGranted;
    });

    if (!isGranted) {
      _navigateToPermissionPage();
    } else {
      _fetchUsageStats();
    }
  }

  void _navigateToPermissionPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => PermissionHandlerPage(),
        ),
      );
    });
  }

  Future<void> _fetchUsageStats() async {
    final List<AppUsageData> usageData =
        await _usageStatsService.fetchUsageStats();
    setState(() {
      _usageData = usageData;
    });
  }

  Widget _buildAppIcon(String? iconBase64) {
    if (iconBase64 == null || iconBase64.isEmpty) {
      return Icon(Icons.android, size: 40); // Ikon default
    } else {
      final imageBytes = base64Decode(iconBase64);
      return Image.memory(
        imageBytes,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      );
    }
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
                  Expanded(
                    child: _usageData.isEmpty
                        ? Center(child: Text("Data tidak ditemukan"))
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                UsageStatsChart(
                                  title: "Penggunaan Aplikasi",
                                  yText: "Waktu (menit)",
                                  usageData: _usageData,
                                  // titleFontSize: 18.0, // Atur ukuran font judul
                                  // axisTitleFontSize:
                                  //     16.0, // Atur ukuran font judul sumbu Y
                                  // axisLabelFontSize:
                                  //     14.0, // Atur ukuran font label sumbu
                                  // dataLabelFontSize:
                                  //     12.0, // Atur ukuran font label data
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: _usageData.length,
                                    itemBuilder: (context, index) {
                                      final data = _usageData[index];
                                      return ListTile(
                                        leading: _buildAppIcon(data.iconBase64),
                                        title: Text(data.packageName),
                                        subtitle: Text(
                                            "Usage: ${data.usageTime} minutes"),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
