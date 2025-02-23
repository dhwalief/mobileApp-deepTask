import 'package:deeptask/constant/app_color.dart';
import 'package:deeptask/screens/stat_page.dart';
import 'package:deeptask/util/usage_stats.dart';
import 'package:flutter/material.dart';

class PermissionHandlerPage extends StatefulWidget {
  const PermissionHandlerPage({super.key});

  @override
  State<PermissionHandlerPage> createState() => _PermissionHandlerPageState();
}

class _PermissionHandlerPageState extends State<PermissionHandlerPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Tambahkan observer
    _checkPermissionStatus(); // Cek status izin saat halaman di-load
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Hapus observer
    super.dispose();
  }

  // Metode ini dipanggil ketika aplikasi dilanjutkan
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Ketika aplikasi dilanjutkan, periksa status izin
      _checkPermissionStatus();
    }
  }

  // Metode untuk memeriksa status izin
  Future<void> _checkPermissionStatus() async {
    final bool isGranted = await PermissionHandlerUtil.checkPermission();
    if (isGranted) {
      // Jika izin sudah diberikan, navigasi kembali ke OtherPage
      _navigateToOtherPage();
    }
  }

  // Metode untuk menavigasi ke OtherPage
  void _navigateToOtherPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => StatPage(),
      ),
    );
  }

  // Metode untuk membuka pengaturan izin akses penggunaan
  void _openUsageAccessSettings() async {
    await PermissionHandlerUtil.openUsageAccessSettings();
    // Setelah membuka pengaturan, biarkan didChangeAppLifecycleState menangani navigasi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.surface,
      appBar: AppBar(
        backgroundColor: AppColor.surface,
        title: Text("Permintaan Izin"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Anda perlu memberikan izin untuk mengakses fitur ini.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: AppColor.onSurface),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openUsageAccessSettings,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.tersier,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Berikan Izin",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
