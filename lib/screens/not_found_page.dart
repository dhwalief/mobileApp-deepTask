import 'package:flutter/material.dart';

class NotfoundPage extends StatelessWidget {
  const NotfoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.not_interested_sharp), Text("Not found")],
        ),
      ),
    );
  }
}
