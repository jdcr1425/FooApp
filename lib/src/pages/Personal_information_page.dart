import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PersonalInformation extends StatefulWidget {
  PersonalInformation({Key key}) : super(key: key);

  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nombre'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'El nombre es requerido';
        }
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildAge() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Edad'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'La edad es requerida';
        } else {
          final number = num.tryParse(value);
          if (number == null) {
            return '"$value" no es un numero válido';
          }
        }
      },
      onSaved: (value) {
        _age = int.parse(value);
      },
    );
  }

  Widget _buildGender() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Sexo",
          style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
        ),
        DropdownButton<String>(
            value: _genderValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Color.fromRGBO(19, 48, 119, 1.0)),
            underline: Container(
              height: 2,
              color: Color.fromRGBO(19, 48, 119, 1.0),
            ),
            onChanged: (String valure) {
              setState(() {
                _genderValue = valure;
              });
            },
            items: <String>['Masculino', 'Femenino']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList())
      ],
    );
  }

  Widget _buildProfession() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'profesión'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'La profesión es requerida';
        }
      },
      onSaved: (String value) {
        _profession = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 20,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xfff0f0f0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 10.0, offset: Offset(5, 5))
            ]),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Datos personales",
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
                _buildName(),
                _buildAge(),
                _buildGender(),
                _buildProfession(),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();

                    var person = {
                      "Name": this._name,
                      "Age": this._age,
                      "Gender": this._genderValue,
                      "Profession": this._profession
                    };

                    String user = jsonEncode(person);
                    _saveUser(user);

                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Guardado exitoso')));

                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.save,
                        color: Color.fromRGBO(19, 48, 119, 1.0),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Guardar")
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
