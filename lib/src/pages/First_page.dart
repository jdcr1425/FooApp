import 'package:flutter/material.dart';
import 'package:olores/src/pages/third_page.dart';

class FirstBlock extends StatefulWidget {
  FirstBlock({Key key}) : super(key: key);

  _FirstBlockState createState() => _FirstBlockState();
  static final routeName = 'first';
}

class _FirstBlockState extends State<FirstBlock> {
  static final _olores = [
    'Orina',
    'Huevo podrido',
    'Excremento',
    'Fruta podrida',
    'Aguas negras',
    'Cebolla',
    'Podredumbre',
    'Gasolina',
    'Residuos',
    'Pescado',
    'Humo',
    'Ácido',
    'Carnicerías y pollerías',
    'Dulce',
    'Otro'
  ];
  String _currentItemSelected = _olores[0];
  double sliderIntensidadValue = 5.0;
  double sliderDistincionValue = 5.0;

  static final _sentimientos = ['Positivo', 'Negativo', 'Ninguno'];
  String _currentSentimientoSelected = _sentimientos[0];

  @override
  Widget build(BuildContext context) {
    Map<String, Object> datos = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Descripción del olor",
          ),
          leading: new Container()),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(10),
            children: <Widget>[
              _olor(),
              _intesidadOlor(),
              _distincionOlor(),
              _sentimiento(),
            ],
          ))
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        child: RaisedButton(
          color: Colors.orange,
          textColor: Colors.white,
          onPressed: () => _nextPage(datos, context),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.arrow_right),
              Text('Siguiente', style: TextStyle(fontSize: 16.0)),
            ],
          ),
        ),
      ),
    );
  }

  _nextPage(datos, context) {
    var obje = {
      'Nombre': _currentItemSelected,
      'num': _olores.indexOf(_currentItemSelected),
      'intensidad': sliderIntensidadValue,
      'distincion': sliderDistincionValue,
      'coordenadas': datos['Coordenadas'],
      'lugar': datos['lugar'],
      'sentimiento': _currentSentimientoSelected
    };

    Navigator.pushNamed(context, ThirdBlock.routeName, arguments: obje);
  }

  Widget _olor() {
    return Card(
        margin: EdgeInsets.only(bottom: 10),
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("¿A qué huele?",
                  style: TextStyle(color: Colors.black, fontSize: 17.0)),
              DropdownButton<String>(
                items: _olores.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String newValueSelected) {
                  setState(() {
                    this._currentItemSelected = newValueSelected;
                  });
                },
                value: _currentItemSelected,
              )
            ],
          ),
        ));
  }

  Widget _intesidadOlor() {
    TextStyle negrita = TextStyle(fontWeight: FontWeight.bold);

    return Card(
        margin: EdgeInsets.only(bottom: 10),
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Text("¿La intensidad del olor es?",
                    style: TextStyle(color: Colors.black, fontSize: 17.0)),
                Slider(
                  min: 0.0,
                  max: 10.0,
                  divisions: 10,
                  value: sliderIntensidadValue,
                  activeColor: Colors.orange,
                  inactiveColor: Colors.grey,
                  onChanged: (newValue) {
                    setState(() {
                      sliderIntensidadValue = newValue;
                    });
                  },
                ),
                Row(
                  children: <Widget>[
                    Text("Debil", style: negrita),
                    Expanded(child: SizedBox()),
                    Text("Fuerte", style: negrita)
                  ],
                ),
              ],
            )));
  }

  Widget _distincionOlor() {
    TextStyle negrita = TextStyle(fontWeight: FontWeight.bold);

    return Card(
        margin: EdgeInsets.only(bottom: 10),
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Text("¿Qué tanto se distingue el olor?",
                    style: TextStyle(color: Colors.black, fontSize: 17.0)),
                Slider(
                  min: 0.0,
                  max: 10.0,
                  divisions: 10,
                  value: sliderDistincionValue,
                  activeColor: Colors.orange,
                  inactiveColor: Colors.grey,
                  onChanged: (newValue) {
                    setState(() {
                      sliderDistincionValue = newValue;
                    });
                  },
                ),
                Row(
                  children: <Widget>[
                    Text("Poco", style: negrita),
                    Expanded(child: SizedBox()),
                    Text("Mucho", style: negrita)
                  ],
                )
              ],
            )));
  }

  _sentimiento() {
    return Card(
        margin: EdgeInsets.only(bottom: 10),
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("¿Este tipo de olor que tipo de sentimiento te genera?",
                  style: TextStyle(color: Colors.black, fontSize: 17.0),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                items: _sentimientos.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String newValueSelected) {
                  setState(() {
                    this._currentSentimientoSelected = newValueSelected;
                  });
                },
                value: _currentSentimientoSelected,
              )
            ],
          ),
        ));
  }
}
