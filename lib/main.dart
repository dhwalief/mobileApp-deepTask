import 'package:deeptask/pages/main_page.dart';
import 'package:deeptask/pages/setting_page.dart';
import 'package:deeptask/pages/stat_page.dart';
import 'package:deeptask/pages/task_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Pastikan Flutter sudah diinisialisasi
  await initializeDateFormatting('id_ID', null); // Inisialisasi untuk Indonesia
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
          '/statpage': (context) => const StatPage(),
          '/settingpage': (context) => const SettingPage(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFFFFFFFF),
            surface: Color(0xFFF8F8F8),
            primary: Color(0xFFFFFFFF),
            onPrimary: Color(0xFF7c7c7c),
            secondary: Color(0xFF1B264F),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xfff8f8f8),
          ),
        ));
  }
}
