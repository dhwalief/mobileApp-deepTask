// lib/services/permission_handler_service.dart
import 'package:deeptask/util/usage_stats_util.dart';

class PermissionHandlerService {
  Future<bool> checkPermissionStatus() async {
    return await PermissionHandlerUtil.checkPermission();
  }

  Future<void> openUsageAccessSettings() async {
    await PermissionHandlerUtil.openUsageAccessSettings();
  }
}
