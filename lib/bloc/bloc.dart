import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_block/bloc/event.dart';
import 'package:todo_with_block/bloc/state.dart';
import 'package:todo_with_block/model/task.dart';
import 'package:todo_with_block/repository/task_repositary.dart';
import 'package:uuid/uuid.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc({required this.repository}) : super(TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<FilterTasks>(_onFilterTasks);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await repository.getTasks();
      emit(TasksLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError('Failed to load tasks: $e'));
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    try {
      final task = Task(
        id: const Uuid().v4(),
        title: event.title,
        description: event.description,
        createdAt: DateTime.now(),
      );
      await repository.insertTask(task);
      add(LoadTasks());
    } catch (e) {
      emit(TaskError('Failed to add task: $e'));
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    try {
      await repository.updateTask(event.task);
      add(LoadTasks());
    } catch (e) {
      emit(TaskError('Failed to update task: $e'));
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    try {
      await repository.deleteTask(event.taskId);
      add(LoadTasks());
    } catch (e) {
      emit(TaskError('Failed to delete task: $e'));
    }
  }

  void _onFilterTasks(FilterTasks event, Emitter<TaskState> emit) {
    final currentState = state;
    if (currentState is TasksLoaded) {
      emit(TasksLoaded(tasks: currentState.tasks, filter: event.filter));
    }
  }
}
