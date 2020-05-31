import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:olores/src/pages/Personal_information_page.dart';
import 'package:flutter/material.dart';
import 'Register_page.dart';
import 'Show_page.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedDrawerItem = 0;
  bool isUser = false;
  String _name = "";
  String profession = "";
  String initials = "";

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  _deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    Navigator.pushNamed(context, '/');
  }

  _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('user') == null) {
      setState(() {
        this.isUser = false;
      });
    } else {
      setState(() {
        this.isUser = true;
        Map<String, dynamic> user = jsonDecode(prefs.getString('user'));
        this._name = user["Name"];
        this.profession = user["Profession"];
        if (_name.split(' ').length > 1) {
          List<String> name = _name.split(' ');
          this.initials = name[0][0] + name[1][0];
        } else {
          this.initials = "UTB";
        }
      });
    }
  }

  Widget _getDrawerItemWidget(pos) {
    switch (pos) {
      case 0:
        return isUser ? Register() : PersonalInformation();
        break;
      case 1:
        return Show();
        break;
      case 2:
        return PersonalInformation();
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Olores', style: GoogleFonts.roboto()),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                exit(0);
              })
        ],
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  this._name.isEmpty ? "Proyecto olores" : this._name,
                  style: GoogleFonts.roboto(),
                ),
                accountEmail: Text(
                    this.profession.isEmpty
                        ? "Facultad Ingenieria"
                        : this.profession,
                    style: GoogleFonts.roboto()),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    this.initials.isNotEmpty ? this.initials : "UTB",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(fontSize: 30.0)),
                  ),
                ),
              ),
              ListTile(
                title: Text('Registrar olor'),
                selected: (_selectedDrawerItem == 0),
                leading: Icon(Icons.add),
                onTap: () {
                  if (_selectedDrawerItem != 0) {
                    Navigator.of(context).pop();
                  }

                  setState(() {
                    _selectedDrawerItem = 0;
                  });
                },
              ),
              ListTile(
                title: Text('Mostrar registros'),
                selected: (_selectedDrawerItem == 1),
                leading: Icon(Icons.show_chart),
                onTap: () {
                  if (_selectedDrawerItem != 1) {
                    Navigator.of(context).pop();
                  }
                  setState(() {
                    _selectedDrawerItem = 1;
                  });
                },
              ),
              ListTile(
                  title: Text(
                      this._name.isEmpty ? "Registrar datos personales" : "Borrar datos personales"),
                  selected: (_selectedDrawerItem == 2),
                  leading: this._name.isNotEmpty
                      ? Icon(Icons.cancel)
                      : Icon(Icons.arrow_right),
                  onTap: () {
                    if (this._name.isEmpty) {
                      if (_selectedDrawerItem != 2) {
                        Navigator.of(context).pop();
                      }
                      setState(() {
                        _selectedDrawerItem = 2;
                      });
                    } else {
                      _deleteUser();
                    }
                  }),
              ListTile(
                  title: Text("Salir"),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () {
                    exit(0);
                  })
            ],
          ),
        ),
      ),
      body: SafeArea(child: _getDrawerItemWidget(_selectedDrawerItem)),
    );
  }
}
