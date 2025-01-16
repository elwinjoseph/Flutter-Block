import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_block/bloc/bloc.dart';
import 'package:todo_with_block/bloc/event.dart';
import 'package:todo_with_block/bloc/state.dart';
import 'package:todo_with_block/model/task.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo List'),
            actions: [
              PopupMenuButton<TaskFilter>(
                onSelected: (filter) {
                  context.read<TaskBloc>().add(FilterTasks(filter: filter));
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: TaskFilter.all,
                    child: Text('All'),
                  ),
                  const PopupMenuItem(
                    value: TaskFilter.completed,
                    child: Text('Completed'),
                  ),
                  const PopupMenuItem(
                    value: TaskFilter.pending,
                    child: Text('Pending'),
                  ),
                ],
              ),
            ],
          ),
          body: _buildBody(context, state),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAddDialog(context),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, TaskState state) {
    if (state is TaskLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is TasksLoaded) {
      if (state.filteredTasks.isEmpty) {
        return const Center(child: Text('No tasks found'));
      }

      return ListView.builder(
        itemCount: state.filteredTasks.length,
        itemBuilder: (context, index) {
          final task = state.filteredTasks[index];
          return Dismissible(
            key: Key(task.id),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 16.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              context.read<TaskBloc>().add(DeleteTask(taskId: task.id));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task deleted')),
              );
            },
            child: ListTile(
              title: Text(
                task.title,
                style: TextStyle(
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Text(task.description),
              leading: Checkbox(
                value: task.isCompleted,
                onChanged: (_) {
                  context.read<TaskBloc>().add(
                        UpdateTask(
                          task: task.copyWith(isCompleted: !task.isCompleted),
                        ),
                      );
                },
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  context.read<TaskBloc>().add(DeleteTask(taskId: task.id));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Task deleted')),
                  );
                },
              ),
              onTap: () => _showEditDialog(context, task),
            ),
          );
        },
      );
    }

    if (state is TaskError) {
      return Center(child: Text(state.message));
    }

    return const Center(child: Text('Something went wrong'));
  }

  void _showAddDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              autofocus: true,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                // Use the outer context to access the BlocProvider
                context.read<TaskBloc>().add(
                      AddTask(
                        title: titleController.text,
                        description: descriptionController.text,
                      ),
                    );
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, Task task) {
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              autofocus: true,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                // Use the outer context to access the BlocProvider
                context.read<TaskBloc>().add(
                      UpdateTask(
                        task: task.copyWith(
                          title: titleController.text,
                          description: descriptionController.text,
                        ),
                      ),
                    );
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
