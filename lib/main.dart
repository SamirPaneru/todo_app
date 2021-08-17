import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model2.dart';
import 'db/database2.dart';

void main() => runApp(MaterialApp(
      title: "TODO App",
      home: TODOAPP(),
    ));

class TODOAPP extends StatefulWidget {
  final int? number;
  final String? todos;
  // final ValueChanged<int> onChangedNumber;
  // final ValueChanged<String> onChangedTodos;
  final int? todoId;
  final Todo? currentTodo;

  const TODOAPP({
    Key? key,
    this.number = 0,
    this.todos = '',
    // required this.onChangedNumber,
    // required this.onChangedTodos,
    this.todoId,
    this.currentTodo,
  }) : super(key: key);

  @override
  _TODOAPPState createState() => _TODOAPPState();
}

class _TODOAPPState extends State<TODOAPP> {
  List<Todo> lists = [];

  late Todo currenttodo;

  set todoId(Future<int> todoId) {}

  @override
  void initState() {
    super.initState();

    refreshTodo();
  }

  Future refreshTodo() async {
    this.lists = await TodoDatabase.instance.getAllTodo();
    setState(() {
      lists = lists;
    });
  }

  Widget build(BuildContext context) {
    // show();
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO App"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          this.todoId = TodoDatabase.instance.insertTodo(currenttodo);
          refreshTodo();
        },
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
            // textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: "Add TODO",
            ),
            onChanged: (text) {
              currenttodo = Todo(todos: text);
            },
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: lists.length,
              itemBuilder: (context, index) {
                // currenttodo = lists.elementAt(index);
                return ListTile(
                    leading: Icon(Icons.info),
                    title: Text('${lists[index].todos}'),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          // currentTodo =
                          //     await Todo(todos: '${lists[index].todos}');
                          // int? x = currentTodo.id;
                          // _todoDatabase.deleteTodo(x);
                          // int? x;
                          // currentTodo = Todo(todos: '${lists[index].todos}');
                          // x = currentTodo.id;

                          await TodoDatabase.instance.deleteTodo(index);

                          refreshTodo();
                        }));
              },
            ),
          )
        ],
      ),
    );
  }
}
