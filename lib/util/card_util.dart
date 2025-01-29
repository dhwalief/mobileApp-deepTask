// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class CardUtil extends StatelessWidget {
//   final List tasks;
//   // final Widget child;
//   // final Color color;

//   const CardUtil({
//     super.key,
//     required this.tasks,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Slidable(
//         endActionPane: ActionPane(motion: ScrollMotion(), children: [
//           SlidableAction(
//             onPressed: (context) {
//               setState(() {
//                 tasks[index].removeAt(index2);
//               });
//             },
//             icon: Icons.delete,
//             foregroundColor: Theme.of(context).colorScheme.error,
//           ),
//         ]),
//         child: Card(
//             color: Theme.of(context).colorScheme.surface,
//             child: ListTile(
//               title: Text(
//                 tasks[index][index2].isEmpty ? 'No task' : tasks[index][index2],
//               ),
//             )));
//   }
// }
