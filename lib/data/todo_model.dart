class Todo {
  int? id;
  String taskName;
  String time;
  String duration;
  String priority;
  bool isCompleted;

  Todo({
    this.id,
    required this.taskName,
    required this.time,
    required this.duration,
    required this.priority,
    this.isCompleted = false,
  });

  // Convert Todo to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskName': taskName,
      'time': time,
      'duration': duration,
      'priority': priority,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  // Convert Map to Todo
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      taskName: map['taskName'],
      time: map['time'],
      duration: map['duration'],
      priority: map['priority'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
