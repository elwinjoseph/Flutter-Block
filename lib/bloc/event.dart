import 'package:todo_with_block/model/task.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String title;
  final String description;

  AddTask({required this.title, this.description = ''});
}

class UpdateTask extends TaskEvent {
  final Task task;

  UpdateTask({required this.task});
}

class DeleteTask extends TaskEvent {
  final String taskId;

  DeleteTask({required this.taskId});
}

class FilterTasks extends TaskEvent {
  final TaskFilter filter;

  FilterTasks({required this.filter});
}

enum TaskFilter { all, completed, pending }
