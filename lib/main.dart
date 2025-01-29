import 'package:deeptask/display/details_task_display.dart';
import 'package:deeptask/display/stat_display.dart';
import 'package:deeptask/pages/feature_page/add_task_page.dart';
import 'package:deeptask/pages/feature_page/preference_setting_page.dart';
import 'package:deeptask/pages/main_page.dart';
import 'package:deeptask/pages/setting_page.dart';
import 'package:deeptask/pages/stat_page.dart';
import 'package:deeptask/pages/task_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
        routes: {
          '/taskpage': (context) => const TaskPage(),
          '/statpage': (context) => StatPage(),
          '/settingpage': (context) => const SettingPage(),
          '/addtaskpage': (context) => const AddTaskPage(),
          //deploy
          '/barchartpage': (context) => UsageBarChart(),
          '/detailtaskpage': (context) => DetailsTaskDisplay(),
          '/preferenceSetting': (context) => PreferenceSettingPage(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFFFFFFFF),
            primary: Color(0xFF1B264F),
            onPrimary: Color(0xFFFFFFFF),
            secondary: Color(0xFFFFFFFF),
            onSecondary: Color(0xFF000000),
            surface: Color(0xFFF8F8F8),
            onSurface: Color(0xFF000000),
            surfaceContainerHigh: Color(0xFFFFFFFF),
            onSurfaceVariant: Color(0xFFFFFFFF),
            error: Color(0xFFB00020),
            onError: Color(0xFFF8F8F8),
          ),
          useMaterial3: true,
          // appBarTheme: const AppBarTheme(
          //   backgroundColor: Color(0xfff8f8f8),
          // ),
        ));
  }
}
