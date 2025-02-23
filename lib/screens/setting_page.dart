import 'package:deeptask/constant/app_color.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.onPrimary,
        title: Text(
          'Setting',
        ),
      ),
      backgroundColor: AppColor.surface,
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                title: Text("Preference"),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.onSecondary,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/preferenceSetting');
                },
              ),
              color: AppColor.secondary,
            ),
            Card(
              child: ListTile(
                title: Text("Block App Setting"),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.onSecondary,
                ),
              ),
              color: AppColor.secondary,
            )
          ],
        ),
      ),
    );
  }
}
