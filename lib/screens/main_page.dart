import 'package:deeptask/constant/app_color.dart';
import 'package:deeptask/screens/setting_page.dart';
import 'package:deeptask/screens/stat_page.dart';
import 'package:deeptask/screens/task_page.dart';
import 'package:deeptask/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0); // Controller untuk tab
  final ValueNotifier<int> _currentIndexNotifier =
      ValueNotifier<int>(0); // ValueNotifier untuk memantau indeks tab

  @override
  void initState() {
    super.initState();
    // Perbarui ValueNotifier saat tab berubah
    _controller.addListener(() {
      _currentIndexNotifier.value = _controller.index;
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Hapus listener saat widget dihancurkan
    _currentIndexNotifier.dispose(); // Hapus ValueNotifier
    super.dispose();
  }

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
      body: Stack(
        children: [
          // Persistent Bottom Navigation Bar
          PersistentBottomNavBar(
            items: navItems,
            controller: _controller,
          ),

          // FloatingActionButton yang muncul di atas PersistentBottomNavBar
          ValueListenableBuilder<int>(
            valueListenable: _currentIndexNotifier,
            builder: (context, index, child) {
              return index == 0 // Muncul hanya di TaskPage
                  ? Positioned(
                      right: 20, // Jarak dari sisi kanan
                      bottom:
                          90, // Jarak dari bawah (diatas PersistentBottomNavBar)
                      child: FloatingActionButton(
                        onPressed: () {
                          // Aksi saat FAB ditekan
                          Navigator.pushNamed(context, '/addtaskpage');
                        },
                        backgroundColor: AppColor.primary,
                        child: Icon(Icons.add, color: AppColor.onPrimary),
                      ),
                    )
                  : SizedBox(); // Kosong jika bukan TaskPage
            },
          ),
        ],
      ),
    );
  }
}
