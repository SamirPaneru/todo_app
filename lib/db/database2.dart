// Using raw sql
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/todo_model2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

class TodoDatabase {
  late Database database;

  TodoDatabase() {
    initDB();
  }

  Future initDB() async {
    // Avoid errors caused by flutter upgrade
    WidgetsFlutterBinding.ensureInitialized();

    // Set the pathe to the database. Note: Using the 'join' function from the
    // path package is best practice to ensure the path is correctly
    // constructed for each platform.
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'todo_database2.db');

    // Open the database and store the reference
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $todoTable(
          $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
          $todosColumn TEXT
        );
      ''');
    });
  }

  // FutureOr<void> _createDB(Database db, int version) async {
  //   await db.execute('''
  //     CREATE TABLE $todoTable(
  //       $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
  //       $todosColumn TEXT);

  //   '''); //INSERT INTO $todoTable($idColumn, $todosColumn) VALUES(0, 'hello');
  // }

  Future<int> insertTodo(Todo todo) async {
    final db = database;

    return db.insert(todoTable, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // A method to retrieves all the todos from the table
  Future<List<Todo>> getAllTodo() async {
    final db = database;

    List<Map<String, dynamic>> maps = await db.query('$todoTable');

    print(maps);
    // Convert the List<Map<String, dynamic>> into a List<Dog>
    return List.generate(
        maps.length,
        (index) => Todo(
              id: maps[index]['$idColumn'],
              todos: maps[index]['$todosColumn'],
            ));
  }

  // Future<Todo> getTodo(int id) async {
  //   List<Ma
  // }

  // Delete todos
  Future<void> deleteTodo(int id) async {
    final db = database;
    print('delete');

    await db.delete(todoTable, where: '$idColumn = ?', whereArgs: [id]);
    print('delete2');
  }
}
