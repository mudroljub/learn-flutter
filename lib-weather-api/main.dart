import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(
      primaryColor: Colors.purple[400],
      accentColor: Colors.cyan[600],
    ),
  ));
}

class Weather extends StatelessWidget {
  final Map<String, dynamic> data;
  Weather(this.data);
  Widget build(BuildContext context) {
    String city = data['city']['name'];
    double temp = data['list'][0]['main']['temp'];
    String weather = data['list'][0]['weather'][0]['description'];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '$city',
          style: Theme.of(context).textTheme.display1,
        ),
        Text(
          '${temp.toStringAsFixed(1)} °C',
          style: Theme.of(context).textTheme.display4,
        ),
        Text(
          '$weather',
          style: Theme.of(context).textTheme.subhead,
        ),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Future<http.Response> _response;

  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _response = http.get(
          'http://api.openweathermap.org/data/2.5/forecast?q=Belgrade&units=metric&APPID=14cc828bff4e71286219858975c3e89a');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: _loadData,
      ),
      body: Center(
        child: FutureBuilder(
          future: _response,
          builder:
              (BuildContext context, AsyncSnapshot<http.Response> response) {
            if (!response.hasData) return Text('Loading...');
            if (response.data.statusCode != 200) {
              return Text('Could not connect to weather service.');
            }
            Map<String, dynamic> data = json.decode(response.data.body);
            print(data['cod']);
            return Weather(data);
          },
        ),
      ),
    );
  }
}
