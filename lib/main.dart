import 'views/category.dart';
import 'package:flutter/material.dart';
import './views/index.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Index(),
      routes: {
        '/index': MaterialPageRoute(builder: (context) => Index()).builder,
        '/category':
            MaterialPageRoute(builder: (context) => Category()).builder,
      },
    );
  }
}
