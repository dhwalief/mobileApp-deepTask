// import 'package:flutter/material.dart';

// class AddTaskUtil extends StatelessWidget {
//   String taskName;
//   Function(String?)? value;

//   AddTaskUtil({super.key, required this.taskName, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//         border: const OutlineInputBorder(),
//         labelText: taskName,
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return "Silahkan masukkan $taskName";
//         }
//         return null;
//       },
//       onSaved: (value) {
//         return taskName;
//       },
//     );
//   }
// }
