import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:deeptask/constant/app_color.dart';

class TaskTile extends StatelessWidget {
  final String taskName;
  final String time;
  final Function() onDelete;
  final Function() onTap;

  const TaskTile({
    Key? key,
    required this.taskName,
    required this.time,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(taskName),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onDelete(),
            icon: Icons.delete,
            foregroundColor: AppColor.error,
          ),
        ],
      ),
      child: Card(
        color: AppColor.secondary,
        child: ListTile(
          title: Text(
            taskName.isEmpty ? 'No task' : taskName,
          ),
          trailing: Text(
            time,
            style: TextStyle(color: AppColor.onSurface),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
