// import 'package:permission_handler/permission_handler.dart';

// Future<bool> requestUsageStatsPermission() async {
//   var status = await Permission.accessUsage.status;
//   if (status.isDenied) {
//     // Izin belum diberikan, minta izin
//     status = await Permission.accessUsage.request();
//     if (status.isGranted) {
//       return true; // Izin diberikan
//     } else {
//       // Izin ditolak
//       if (await Permission.accessUsage.isPermanentlyDenied) {
//         // Izin ditolak secara permanen, arahkan pengguna ke pengaturan aplikasi
//         openAppSettings();
//       }
//       return false;
//     }
//   } else if (status.isGranted) {
//     return true; // Izin sudah diberikan
//   } else {
//     return false; // Izin dibatasi atau ditolak secara permanen
//   }
// }
