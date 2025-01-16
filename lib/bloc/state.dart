import 'package:todo_with_block/bloc/event.dart';
import 'package:todo_with_block/model/task.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TasksLoaded extends TaskState {
  final List<Task> tasks;
  final TaskFilter filter;

  TasksLoaded({
    required this.tasks,
    this.filter = TaskFilter.all,
  });

  List<Task> get filteredTasks {
    switch (filter) {
      case TaskFilter.completed:
        return tasks.where((task) => task.isCompleted).toList();
      case TaskFilter.pending:
        return tasks.where((task) => !task.isCompleted).toList();
      default:
        return tasks;
    }
  }
}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}
