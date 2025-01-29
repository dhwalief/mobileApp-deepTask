// import 'package:deeptask/display/stat_display.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class PermissionDisplay extends StatefulWidget {
//   const PermissionDisplay({super.key});

//   @override
//   State<PermissionDisplay> createState() => _PermissionDisplayState();
// }

// class _PermissionDisplayState extends State<PermissionDisplay> {
//   void dialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           child: Container(
//             padding: EdgeInsets.all(10),
//             child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   maxHeight: 200,
//                   maxWidth: 400,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ElevatedButton(
//                       onPressed: Navigator.,
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               Theme.of(context).colorScheme.primary,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           )),
//                       child: Text(
//                         "Stat Permission",
//                         style: TextStyle(
//                             color: Theme.of(context).colorScheme.onPrimary),
//                       ),
//                     ),
//                   ],
//                 )),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "You need to request permission to access the feature",
//           textAlign: TextAlign.center,
//         ),
//         Center(
//             child: ElevatedButton(
//           onPressed: dialog,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Theme.of(context).colorScheme.primary,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           child: Text("Request Permission",
//               style: TextStyle(
//                   color: Theme.of(context).colorScheme.onPrimary,
//                   fontWeight: FontWeight.w400)),
//         )),
//       ],
//     );
//   }
// }
