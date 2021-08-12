final String tableTodos = 'todos';

class TodoFields {
  static final List<String> values = [
    // Add all fields
    id, description, time
  ];

  // By default we have underscore(_) before id
  static final String id = '_id';
  static final String description = 'description';
  static final String time = 'time';
}

class Todo {
  final int? id;
  final String description;
  final DateTime createdTime;

  const Todo({
    this.id,
    required this.description,
    required this.createdTime,
  });

  static Todo fromJson(Map<String, Object?> json) => Todo(
        id: json[TodoFields.id] as int?,
        description: json[TodoFields.description] as String,
        createdTime: DateTime.parse(json[TodoFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        TodoFields.id: id,
        TodoFields.description: description,
        TodoFields.time: createdTime.toIso8601String(),
      };

  Todo copy({
    int? id,
    String? description,
    DateTime? createdTime,
  }) =>
      Todo(
        id: id ?? this.id,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );
}
