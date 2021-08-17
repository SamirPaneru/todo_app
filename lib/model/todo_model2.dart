// Helper for database2.dart

final String todoTable = 'todoTable';
final String idColumn = '_id';
final String todosColumn = 'todos';

class Todo {
  int? id;
  String? todos;

  Todo({this.id, this.todos});

  // Used to insert row into database including id field
  Map<String, dynamic> toMap() {
    return {idColumn: this.id, todosColumn: this.todos};
  }

  static Todo fromMap(Map<String, Object?> map) => Todo(
        id: map[idColumn] as int?,
        todos: map[todosColumn] as String,
      );
}
