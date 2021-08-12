import 'package:flutter/material.dart';
import 'db/database.dart';

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
  // null xaina vanera bujinxa "late" le
  // used while declaring a non-nullable variable that's..
  // initialised after it's declaration
  late String value;

  var listTODO = ['', 'Hello', 'Hi'];

  addToDo(String item) {
    setState(() {
      listTODO.add(item); // append garxa
    });
  }

  removeToDo(int index) {
    setState(() {
      listTODO.removeAt(index);
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
          onPressed: () {
            addToDo(value);
          },
        ),
        body: ListView.builder(
            itemCount: listTODO.length,
            itemBuilder: (context, index) {
              return index == 0
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Add Item",
                        ),
                        onChanged: (val) {
                          setState(() {
                            value = val;
                          });
                        },
                      ),
                    )
                  : ListTile(
                      leading: Icon(Icons.info),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          removeToDo(index);
                        },
                      ),
                      title: Text('${listTODO[index]}'),
                    );
            }));
  }
}
