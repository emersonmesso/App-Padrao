import 'dart:async';

import 'package:app_site/todo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final List<Todo> todos;
  SplashScreen({Key key, @required this.todos}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    startTime();
  }

  startTime () async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("images/apadrao.png"),
    );
  }
}
