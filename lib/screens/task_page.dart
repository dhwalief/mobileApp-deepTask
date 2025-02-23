import 'package:deeptask/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:deeptask/util/date_now_util.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<List<String>> tasks = [
    ['Task 11', 'Task 12', 'Task 13'],
    ['Task 21', 'Task 22', 'Task 23'],
  ];

  int index0Length = 0, index1Length = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.surface,
      appBar: AppBar(
        backgroundColor: AppColor.surface,
        foregroundColor: AppColor.onSurface,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DateNowUtil(fontSize: 18),
            // const SizedBox(width: 16),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ! start here
            Flexible(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      index == 0
                          ? Text('Today',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600))
                          : Text('This Week',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                      tasks[index].isEmpty
                          ? SizedBox(
                              child: ListTile(
                                title: Text('No task'),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: tasks[index].length,
                              itemBuilder: (context, index2) {
                                return Slidable(
                                  key: ValueKey('$index-$index2'),
                                  endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          setState(() {
                                            tasks[index].removeAt(index2);
                                          });
                                        },
                                        icon: Icons.delete,
                                        foregroundColor: AppColor.error,
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    color: AppColor.secondary,
                                    child: ListTile(
                                      title: Text(
                                        tasks[index][index2].isEmpty
                                            ? 'No task'
                                            : tasks[index][index2],
                                      ),
                                      trailing: Text(
                                        "09.12",
                                        style: TextStyle(
                                            color: AppColor.onSurface),
                                      ),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/detailtaskpage');
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                    ],
                  );
                },
              ),
            )
            // ! end here
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addtaskpage');
                },
                icon: Icon(Icons.add, color: AppColor.onPrimary),
                color: AppColor.primary,
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
