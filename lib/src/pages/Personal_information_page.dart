import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PersonalInformation extends StatefulWidget {
  PersonalInformation({Key key}) : super(key: key);

  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final _formKey = GlobalKey<FormState>();

  String _genderValue = 'Masculino';
  String _name = "";
  int _age = 0;
  String _profession;

  @override
  void initState() {
    super.initState();
  }

  //TO save an user
  _saveUser(person) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', person);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Align(
            child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(24.0),
          shadowColor: Color(0x802196f3),
          child: Container(
            width: 350.0,
            height: 420.0,
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                            child: Text("Regístrate",
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 29))),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(hintText: 'Digite su nombre'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Digite su nombre';
                            } else {
                              this._name = value;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(hintText: 'Digite su edad'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Digite su edad';
                            }
                            final n = num.tryParse(value);
                            if (n == null) {
                              return '"$value" no es un numero válido';
                            } else {
                              this._age = n;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Sexo",
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            DropdownButton(
                                value: _genderValue,
                                icon: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.orange,
                                ),
                                iconSize: 24,
                                elevation: 20,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _genderValue = newValue;
                                  });
                                },
                                items: <String>[
                                  'Masculino',
                                  'Femenino'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList())
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(hintText: 'Digite su profesión'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Digite su profesión';
                            } else {
                              this._profession = value;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Center(
                            child: Container(
                          width: 110.0,
                          height: 50.0,
                          child: FlatButton(
                            color: Colors.orange,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {

                                var person = {
                                  "Name": this._name,
                                  "Age": this._age,
                                  "Gender": this._genderValue,
                                  "Profession": this._profession
                                };

                                String user = jsonEncode(person);
                                _saveUser(user);

                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Registro exitoso')));

                                Navigator.pushNamed(context, '/');
                              }
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(Icons.save),
                                  Text("Guardar")
                                ]),
                          ),
                        ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
