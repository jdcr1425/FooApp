import 'package:flutter/material.dart';

class Show extends StatefulWidget {
  Show({Key key}) : super(key: key);

  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Show> {
  @override
  Widget build(BuildContext context) {
    return  Center(child: Text('Show records'));
  }
}