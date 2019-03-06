import 'package:flutter/material.dart';
import 'Naslovna.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Naslovna(title: 'Mali brojac'),
    );
}