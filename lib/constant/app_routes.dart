import 'package:deeptask/display/details_task_display.dart';
import 'package:deeptask/display/stat_display.dart';
import 'package:deeptask/screens/not_found_page.dart';
import 'package:deeptask/screens/setting_page.dart';
import 'package:deeptask/screens/stat_page.dart';
import 'package:deeptask/screens/task_page.dart';
import 'package:flutter/material.dart';

class AppRoutes extends StatelessWidget {
  const AppRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Definisikan rute-rute yang akan digunakan
      routes: {
        '/taskpage': (context) => const TaskPage(),
        '/statpage': (context) => StatPage(),
        '/settingpage': (context) => const SettingPage(),
        //deploy
        '/barchartpage': (context) => UsageBarChart(),
        '/detailtaskpage': (context) => DetailsTaskDisplay(),
      },

      // Tangani rute yang tidak didefinisikan
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => NotfoundPage());
      },
    );
  }
}
