import 'package:deeptask/screens/setting_page.dart';
import 'package:deeptask/screens/stat_page.dart';
import 'package:deeptask/screens/task_page.dart';
import 'package:deeptask/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // int _selectedPage = 0;

  // void _changePage(int index) {
  //   setState(() {
  //     _selectedPage = index;
  //   });
  // }

  // final List _page = [
  //   TaskPage(),
  //   StatPage(),
  //   SettingPage(),
  // ];

  @override
  Widget build(BuildContext context) {
    List<BottomNavItem> navItems = [
      BottomNavItem(
        text: 'Task',
        icon: Icons.task_outlined,
        destination: TaskPage(),
      ),
      BottomNavItem(
        text: 'Stats',
        icon: Icons.bar_chart_outlined,
        destination: StatPage(),
      ),
      BottomNavItem(
        text: 'Setting',
        icon: Icons.settings,
        destination: SettingPage(),
      ),
    ];

    return Scaffold(
      body: PersistentBottomNavBar(items: navItems),
      // PageStorage(bucket: PageStorageBucket(), child: _page[_selectedPage]),
      // ? Body
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedPage,
      //   onTap: _changePage,
      //   backgroundColor: AppColor.secondary,
      //   selectedItemColor: AppColor.primary,
      //   enableFeedback: false,
      //   // unselectedItemColor: Colors.grey,
      //   selectedIconTheme: const IconThemeData(),
      //   showUnselectedLabels: false,
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.task_outlined,
      //       ),
      //       label: 'Task',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.bar_chart_outlined),
      //       label: 'Statistic',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings_outlined),
      //       label: 'Settings',
      //     ),
      //   ],
      // ),
    );
  }
}
