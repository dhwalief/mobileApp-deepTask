import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Setting',
        ),
      ),
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
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/preferenceSetting');
                },
              ),
              color: Theme.of(context).colorScheme.surface,
            ),
            Card(
              child: ListTile(
                title: Text("Block App Setting"),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              color: Theme.of(context).colorScheme.surface,
            )
          ],
        ),
      ),
    );
  }
}
