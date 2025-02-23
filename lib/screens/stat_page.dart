import 'package:flutter/material.dart';
import 'package:deeptask/constant/app_color.dart';
import 'package:deeptask/screens/permission_handler_page.dart';
import 'package:deeptask/util/usage_stats.dart';

class StatPage extends StatefulWidget {
  const StatPage({super.key});

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  bool _isGranted = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.surface,
      body: _isGranted
          ? Center(
              child: Text(
                "Data Usage Stats",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            )
          : Center(
              child: CircularProgressIndicator(), // Tampilkan loading indicator
            ),
    );
  }
}
