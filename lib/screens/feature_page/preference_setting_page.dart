import 'package:flutter/material.dart';

class PreferenceSettingPage extends StatelessWidget {
  const PreferenceSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Preference Setting',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text("Dark Mode"),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Add custom quotes"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  Navigator.pushNamed(context, '/addQuotes');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
