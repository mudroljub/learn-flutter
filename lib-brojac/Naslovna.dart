import 'package:flutter/material.dart';

class Naslovna extends StatefulWidget {
  Naslovna({Key key, this.title}) : super(key: key);

  final String title;

  @override
  createState() => _StanjeBrojaca();
}

class _StanjeBrojaca extends State<Naslovna> {
  int _brojac = 0;

  void _povecajBrojac() => setState(() {
        _brojac++;
      });

  void _umanjiBrojac() => setState(() {
        _brojac--;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.yellow[50],
      body: _buildBody(),
      floatingActionButton: _buildButtons(),
    );
  }

  Widget _buildBody() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pritisnuli ste dugme',
              style: Theme.of(context).textTheme.headline,
            ),
            Text(
              '$_brojac',
              style: Theme.of(context).textTheme.display4,
            ),
            Text(
              'puta',
              style: Theme.of(context).textTheme.headline,
            ),
          ],
        ),
      );

  Widget _buildButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _umanjiBrojac,
            child: Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: _povecajBrojac,
            child: Icon(Icons.add),
          )
        ],
      );
}
