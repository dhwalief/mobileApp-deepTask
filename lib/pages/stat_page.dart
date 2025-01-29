import 'package:deeptask/display/permission_display.dart';
import 'package:deeptask/display/stat_display.dart';
// import 'package:deeptask/util/permission_handler_page_util.dart';
import 'package:flutter/material.dart';

class StatPage extends StatelessWidget {
  StatPage({super.key});

  bool isGranted = false;
  void checkPermission() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: PermissionHandlerUtil(), ?? main
        body: UsageBarChart());
  }
}
