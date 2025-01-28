import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.surface,
        title:
            //  Text('Setting')
            Text(
          'Setting',
          style: TextStyle(
              fontSize: 18, color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Theme.of(context).colorScheme.primary,
              child: ListTile(
                title: Text('Dark Mode'),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ),
            Card(
              color: Theme.of(context).colorScheme.primary,
              child: ListTile(
                title: Text('Notification'),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
