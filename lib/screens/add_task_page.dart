import 'package:deeptask/data/todo_database_helper.dart';
import 'package:deeptask/data/todo_model.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _taskNameController = TextEditingController();
  final _timeController = TextEditingController();
  final _durationController = TextEditingController();
  final _priorityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _taskNameController,
                decoration: InputDecoration(labelText: 'Nama Tugas'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tugas tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Waktu (HH:mm)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Waktu tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _durationController,
                decoration: InputDecoration(labelText: 'Durasi (menit)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Durasi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priorityController,
                decoration: InputDecoration(labelText: 'Prioritas (1-5)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Prioritas tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final todo = Todo(
                      taskName: _taskNameController.text,
                      time: _timeController.text,
                      duration: _durationController.text,
                      priority: _priorityController.text,
                    );
                    await DatabaseHelper().insertTodo(todo);
                    Navigator.pop(context);
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
