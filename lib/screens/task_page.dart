import 'package:deeptask/data/todo_database_helper.dart';
import 'package:deeptask/data/todo_model.dart';
import 'package:deeptask/screens/add_task_page.dart';
import 'package:deeptask/widgets/task_tile_widget.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late Future<List<Todo>> _todosFuture;

  @override
  void initState() {
    super.initState();
    _todosFuture = DatabaseHelper().getTodos();
  }

  void _refreshTodos() {
    setState(() {
      _todosFuture = DatabaseHelper().getTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: _todosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada tugas'));
          } else {
            final todos = snapshot.data!;
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return TaskTile(
                  taskName: todo.taskName,
                  time: todo.time,
                  onDelete: () async {
                    await DatabaseHelper().deleteTodo(todo.id!);
                    _refreshTodos();
                  },
                  onTap: () {
                    // Navigasi ke halaman detail task (opsional)
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage()),
          ).then((_) => _refreshTodos());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
