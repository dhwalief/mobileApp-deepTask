import 'package:deeptask/util/permission_handler_page_util.dart';
import 'package:flutter/material.dart';

class StatPage extends StatelessWidget {
  const StatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PermissionHandlerUtil(),
    );
  }
}
