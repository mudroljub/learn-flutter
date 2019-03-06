import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const url = 'https://jsonplaceholder.typicode.com/posts/1';

Future<Post> fetchPost() async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

void main() => runApp(
      MyApp(
        post: fetchPost(),
      ),
    );

class MyApp extends StatelessWidget {
  final Future<Post> post;

  MyApp({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FutureBuilder<Post>(
                future: post,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return Text(
                      snapshot.data.title,
                      style: Theme.of(context).textTheme.display1,
                    );
                  if (snapshot.hasError) return Text("${snapshot.error}");
                  return CircularProgressIndicator(); // a loading spinner
                },
              ),
              FutureBuilder<Post>(
                future: post,
                builder: (context, snapshot) {
                  if (snapshot.hasData) return Text(snapshot.data.body);
                  if (snapshot.hasError) return Text("${snapshot.error}");
                  return CircularProgressIndicator(); // a loading spinner
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
