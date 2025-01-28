import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CardUtil extends StatelessWidget {
  final Widget child;
  final Color color;

  const CardUtil({super.key, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: color ?? Theme.of(context).colorScheme.primary,
        child: Slidable(
            child: Card(
          color: color ?? Theme.of(context).colorScheme.primary,
          child: child,
        )));
  }
}
