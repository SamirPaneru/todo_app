import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/todo.dart';
import 'package:path/path.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();

  // "?" represents variable might have value null
  static Database? _database;

  TodoDatabase._init();

  Future<Database> get database async {
    // we add ! if we are sure _database or any variable will never be null..
    // https://stackoverflow.com/questions/66860060/in-flutter-dart-why-do-we-sometimes-add-a-question-mark-to-string-when-decl
    if (_database != null) return _database!;

    _database = await _initDB('todo.db');
    return _database!;
  }

  // Initializing database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Create table
  FutureOr<void> _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableTodos(
        ${TodoFields.id} $idType,
        ${TodoFields.description} $textType,
        ${TodoFields.time} $textType,
      )
    ''');
  }

  // CRUD operation
  Future<Todo> create(Todo todo) async {
    // Reference to database
    final db = await instance.database;

    final id = await db.insert(
        tableTodos, todo.toJson()); // toJson() is user defined function
    return todo.copy(id: id); // copy() is user defined function
  }

  Future<Todo> readTodo(int id) async {
    // Reference to database
    final db = await instance.database;

    final maps = await db.query(
      tableTodos,
      columns: TodoFields.values,
      // ? lekhera direct id pass nagarda sql injection bata joginxa
      where: '${TodoFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Todo.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Todo>> readAllTodos() async {
    // Reference to database
    final db = await instance.database;

    final orderBy = '${TodoFields.time} ASC';

    // final result =
    //     await db.rawQuery('SELECT * FROM $tableTodos ORDER BY $orderBy');

    final result = await db.query(tableTodos, orderBy: orderBy);

    return result.map((json) => Todo.fromJson(json)).toList();
  }

  Future<int> update(Todo todo) async {
    // Reference to database
    final db = await instance.database;

    return db.update(
      tableTodos,
      todo.toJson(),
      where: '${TodoFields.id} = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> delete(int id) async {
    // Reference to database
    final db = await instance.database;

    return await db.delete(
      tableTodos,
      where: '${TodoFields.id} = ?',
      whereArgs: [id],
    );
  }

  // Close datadase
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
