import 'package:flutter/material.dart';
import 'TodoList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Todo List app',
        home: TodoList(),
        theme: _createTheme(),
      );

  ThemeData _createTheme() => ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.purple[400],
        accentColor: Colors.orange[900],
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          button: TextStyle(
            fontSize: 15,
          ),
          title: TextStyle(
            fontSize: 24,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
}
