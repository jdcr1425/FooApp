import 'package:flutter/material.dart';
import 'package:olores/src/pages/First_page.dart';
import 'package:olores/src/pages/Home.dart';
import 'package:olores/src/pages/lugar_page.dart';
import 'package:olores/src/pages/third_page.dart';
import 'package:olores/src/pages/Personal_information_page.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color.fromRGBO(19, 48, 119, 1.0),
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
          ),
      title: 'Olores',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => Home(),
        FirstBlock.routeName: (BuildContext context) => FirstBlock(),
        '/lugar': (BuildContext context) => LugarPage(),
        ThirdBlock.routeName: (BuildContext context) => ThirdBlock(),
        '/user': (BuildContext context) => PersonalInformation()
      },
    );
  }
}
