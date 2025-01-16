import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_block/home.dart';
import 'package:todo_with_block/repository/task_repositary.dart';
import 'bloc/bloc.dart';
import 'bloc/event.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => TaskRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<TaskBloc>(
              create: (context) => TaskBloc(
                repository: context.read<TaskRepository>(),
              )..add(LoadTasks()),
            ),
          ],
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
