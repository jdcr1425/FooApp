import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:olores/src/provider/olores_provider.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  LocationData _currentLocation;

  Location _locationService = new Location();
  bool _permission = false;
  String error;

  final olorprovider = new OloresProvider();

  bool isbuttondisabled = false;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
      _currentLocation = location;
    });
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
            height: 400.0,
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Text(
                        '¿Percibe algún olor?',
                        style: TextStyle(color: Colors.black, fontSize: 22.0),
                      ),
                    )),
                SizedBox(
                  height: 100.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _botonSi(),
                    SizedBox(width: 60.0),
                    _botonNo(),
                  ],
                ),
                SizedBox(height: 70.0),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                      "Por favor, en caso de tener gripe, rinitis o cualquier problema que  afecte su capacidad olfativa, no continue con el reporte.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic)),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _botonSi() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.orange,
      textColor: Colors.white,
      onPressed: isbuttondisabled ? null : () => onpressedSI(context),
      padding: EdgeInsets.all(15),
      child: Text('SÍ', style: TextStyle(fontSize: 20.0)),
    );
  }

  Widget _botonNo() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.orange,
      textColor: Colors.white,
      onPressed: isbuttondisabled ? null : () => onpressedNo(context),
      padding: EdgeInsets.all(15),
      child: Text(
        'NO',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  void onpressedNo(context) async {
    var alertdialog = AlertDialog(
      title: Text("Gracias por utilizar la aplicación."),
      content: Text("¿Desea continuar en la aplicación?"),
      actions: <Widget>[
        FlatButton(
          child: Text('Sí'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            exit(0);
          },
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertdialog;
        });
  }

  void onpressedSI(context) async {
    setState(() {
      isbuttondisabled = true;
    });
    _currentLocation = await _locationService.getLocation();
    var latitud = _currentLocation.latitude;
    var longitud = _currentLocation.longitude;

    setState(() {
      isbuttondisabled = false;
    });

    var coordenadas = [latitud, longitud];

    Navigator.pushReplacementNamed(context, '/lugar', arguments: coordenadas);
  }
}
