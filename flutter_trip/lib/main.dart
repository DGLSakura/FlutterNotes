import 'package:flutter/material.dart';
import 'package:fluttertrip/navigator/tab_navigator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabNavigator(),
    );
  }
}

