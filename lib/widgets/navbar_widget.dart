import 'package:deeptask/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomNavItem {
  final String text;
  final IconData icon;
  final Widget destination;

  BottomNavItem({
    required this.text,
    required this.icon,
    required this.destination,
  });
  final zeroList = List<int>.filled(3, 0, growable: true); // [0, 0, 0]
}

class PersistentBottomNavBar extends StatelessWidget {
  final List<BottomNavItem> items;
  const PersistentBottomNavBar({super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow, // Warna shadow dengan transparansi
            spreadRadius: 2, // Seberapa jauh shadow menyebar
            blurRadius: 10, // Seberapa blur shadow
            offset: Offset(0, 4), // Posisi shadow (x, y)
          ),
        ],
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 10),
      navBarHeight: 70,
      screens: items.map((item) => item.destination).toList(),
      items: items.map((item) {
        return PersistentBottomNavBarItem(
          icon: Icon(item.icon),
          title: item.text,
          activeColorPrimary: AppColor.primary,
          inactiveColorPrimary: Colors.grey,
        );
      }).toList(),
      navBarStyle: NavBarStyle.style12, // Anda bisa memilih style yang sesuai
    );
  }
}
