import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoList extends StatefulWidget {
  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Todo lista')),
        body: _buildTodoList(),
        floatingActionButton: FloatingActionButton(
          onPressed: _pushAddScreen,
          tooltip: 'Dodati task',
          child: Icon(Icons.add),
        ),
      );

  Widget _buildTodoList() => ListView.builder(
        itemBuilder: (context, index) {
          if (index < _todoItems.length) {
            return _buildTodoItem(_todoItems[index], index);
          }
        },
      );

  Widget _buildTodoItem(String todoText, int index) => ListTile(
        title: Text(todoText),
        onTap: () => _promptDialog(index),
      );

  Widget _buildAddScreen() => Scaffold(
        appBar: AppBar(title: Text('Dodaj novi task')),
        body: TextField(
          autofocus: true,
          autocorrect: false,
          onSubmitted: _handleAdd,
          decoration: InputDecoration(
            hintText: 'Unesi neki zadatak...',
            contentPadding: const EdgeInsets.all(16.0),
          ),
        ),
      );

  Widget _buildDialog(int index) => AlertDialog(
        title: Text('Oznaci "${_todoItems[index]}" kao uradjeno?'),
        actions: <Widget>[
          FlatButton(
            child: Text('CANCEL'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('OK'),
            onPressed: () => _handleRemove(index),
          )
        ],
      );

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  void _loadState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _todoItems = prefs.getStringList('todolista') ?? [];
    });
  }

  void _handleRemove(index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _todoItems.removeAt(index);
      prefs.setStringList('todolista', _todoItems);
    });
    Navigator.pop(context); // Navigator.of(context).pop();
  }

  void _handleAdd(String task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (task.length > 0) {
      setState(() {
        _todoItems.add(task);
        prefs.setStringList('todolista', _todoItems);
      });
    }
    Navigator.pop(context);
  }

  void _pushAddScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => _buildAddScreen(),
      ),
    );
  }

  void _promptDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) => _buildDialog(index),
    );
  }
}
