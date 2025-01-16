import 'package:sqflite/sqflite.dart';
import 'package:todo_with_block/model/task.dart';
import 'package:todo_with_block/repository/database.dart';

class TaskRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Create
  Future<void> insertTask(Task task) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read
  Future<List<Task>> getTasks() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  // Update
  Future<void> updateTask(Task task) async {
    final db = await _databaseHelper.database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // Delete
  Future<void> deleteTask(String id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
