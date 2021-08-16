import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model2.dart';
import 'db/database2.dart';

void main() => runApp(MaterialApp(
      title: "TODO App",
      home: TODOAPP(),
    ));

class TODOAPP extends StatefulWidget {
  const TODOAPP({Key? key}) : super(key: key);

  @override
  _TODOAPPState createState() => _TODOAPPState();
}

class _TODOAPPState extends State<TODOAPP> {
  final TodoDatabase _todoDatabase = TodoDatabase();

  // final textController = TextEditingController();

  // null xaina vanera bujinxa "late" le
  // used while declaring a non-nullable variable that's..
  // initialised after it's declaration
  late String value;

  late List<Todo> lists = [];

  late Todo currentTodo;

  @override
  Widget build(BuildContext context) {
    // final TodoDatabase _todoDatabase = TodoDatabase();
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO App"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          print("Hello");
          // addToDo(value);
          // currentTodo = Todo(todos: );
          _todoDatabase.insertTodo(currentTodo);
          // print(_todoDatabase.getAllTodo().toString());
          List<Todo> list = await _todoDatabase.getAllTodo();

          setState(() {
            lists = list;
          });
          print(lists.length);
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
              currentTodo = Todo(todos: text);
            },
            // controller: textController,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: lists.length,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: Icon(Icons.info),
                    title: Text('${lists[index].todos}'),
                    //title: Text('${todos[index].todos}'),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await _todoDatabase.deleteTodo(index);
                          List<Todo> list = await _todoDatabase.getAllTodo();
                          setState(() {
                            lists = list;
                          });
                        }));
              },
            ),
          )
        ],
      ),
    );
  }
}
