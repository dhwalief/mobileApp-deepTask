import 'package:deeptask/constant/app_color.dart';
// import 'package:deeptask/screens/setting_page.dart';
// import 'package:deeptask/screens/stat_page.dart';
// import 'package:deeptask/screens/task_page.dart';
import 'package:flutter/material.dart';

class BottomNavItem {
  final String text;
  final IconData icon;
  final Widget destination;

  BottomNavItem({
    required this.text,
    required this.icon,
    required this.destination,
  });
}

class NavbarNativeWidget extends StatefulWidget {
  final List<BottomNavItem> item;
  const NavbarNativeWidget({super.key, required this.item});

  @override
  State<NavbarNativeWidget> createState() => _NavbarNativeWidgetState();
}

class _NavbarNativeWidgetState extends State<NavbarNativeWidget> {
  int _selectedPage = 0;

  void _changePage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  // final List _page = [
  //   TaskPage(),
  //   StatPage(),
  //   SettingPage(),
  // ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedPage,
      onTap: _changePage,
      backgroundColor: AppColor.secondary,
      selectedItemColor: AppColor.primary,
      enableFeedback: false,
      // unselectedItemColor: Colors.grey,
      selectedIconTheme: const IconThemeData(),
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: widget.item
          .map((navItem) => BottomNavigationBarItem(
                icon: Icon(navItem.icon),
                label: navItem.text, // Label diperlukan dan diambil dari text
              ))
          .toList(),
    );
  }
}
