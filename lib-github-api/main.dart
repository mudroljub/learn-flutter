import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() => runApp(MyApp());

Widget _buildView(context, res) {
  if (res.hasData) return _buildListView(res);
  if (res.hasError) return Text("${res.error}");
  return CircularProgressIndicator();
}

Widget _buildListView(res) => ListView.builder(
      itemCount: res.data.length,
      itemBuilder: (BuildContext ctxt, int i) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.network(res.data[i].avatarUrl, width: 100.0),
                Text(
                  res.data[i].name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider()
          ],
        );
      },
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Github API Example'),
        ),
        body: Container(
          child: FutureBuilder<List<User>>(
            future: fetchUsersFromGitHub(),
            builder: (context, res) => _buildView(context, res),
          ),
        ),
      ),
    );
  }

  Future<List<User>> fetchUsersFromGitHub() async {
    final response = await http.get('https://api.github.com/users');
    List data = json.decode(response.body);
    return createUserList(data);
  }

  List<User> createUserList(List data) {
    List<User> list = List();
    for (int i = 0; i < data.length; i++) {
      int id = data[i]["id"];
      String name = data[i]["login"];
      String avatarUrl = data[i]["avatar_url"];
      User user = User(name: name, id: id, avatarUrl: avatarUrl);
      list.add(user);
    }
    return list;
  }
}

class User {
  int id;
  String name;
  String avatarUrl;
  User({this.name, this.id, this.avatarUrl});
}
