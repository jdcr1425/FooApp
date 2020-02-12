import 'package:flutter/material.dart';

import 'package:olores/src/pages/First_page.dart';
import 'package:olores/src/pages/Home.dart';
import 'package:olores/src/pages/lugar_page.dart';
import 'package:olores/src/pages/third_page.dart';
import 'package:olores/src/pages/Personal_information_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange
      ) ,
      title: 'Material App',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/' : (BuildContext context)=> Home(),
        '/first': (BuildContext context) => FirstBlock(),
        '/lugar': (BuildContext context) => LugarPage(),
        '/third' : (BuildContext context) => ThirdBlock(),
        '/user'  : (BuildContext context) => PersonalInformation()

      },
    );
  }
}