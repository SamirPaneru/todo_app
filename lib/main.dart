import 'package:flutter/material.dart';

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
  var listTODO = ['Hello', 'Hi'];

  addToDo(String item) {
    setState(() {
      listTODO.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TODO App"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        body: ListView.builder(
            itemCount: listTODO.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.info),
                title: Text('${listTODO[index]}'),
              );
            }));
  }
}
