import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:olores/src/models/Olor_model.dart';
import 'package:olores/src/provider/olores_provider.dart';
import 'package:olores/src/provider/weather_provider.dart';
import 'dart:convert';


class ThirdBlock extends StatefulWidget {
  ThirdBlock({Key key}) : super(key: key);

  _ThirdBlockState createState() => _ThirdBlockState();
}

class _ThirdBlockState extends State<ThirdBlock> {

  static final _emociones  = ['Tristeza', 'Enojo','Normal', 'Alegría', 'Disgusto', 'Sorpresa','Miedo'];
  static final _reacciones = ['Ninguno','Dolor de Cabeza','Malestar en la nariz', 'Náuseas', 'lagrimeo', 'Irritación de fosas nasales', 'Mareo','Vómito'
                              ,'Irritación en la garganta','Estornudo'];
  String _currentEmocionSelected = _emociones[0];
  String _currentReaccionSelected = _reacciones[0];


  var sliderAfectacionValue = 5.0;
  var sliderResultaValue = 5.0;

  OlorModelo olor = new OlorModelo();

  final olorprovider = new OloresProvider();
  final weatherProvider = new WeatherProvider();
  
  bool isbuttondisabled = false;
  String savedUser;
  

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  _getUser() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.getString('user') == null){
      setState(() {
        this.savedUser = null;
      });
      }else{
        setState(() {
          this.savedUser = prefs.getString('user');
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    Map<String, Object> datos = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Descripción del olor"),
        leading: new Container()
      ),
      body:  ListView(
                padding: EdgeInsets.all(10.0),
                children: <Widget>[
                  _olorAfectacion(),
                  _olorResulta(),
                  _olorEmocion(),
                  _olorReaccion()
                ],
              ),
      
      floatingActionButton: Container( 
            width: 110.0,
            height: 50.0,
              child: FlatButton(
                color: Colors.orange,
                onPressed: isbuttondisabled ? null:() => _registrar(datos, context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                            Icon(Icons.save),
                            Text("Guardar")
                            ]
                ),
              ) ,
            )
      
    );
  }

  Widget _olorAfectacion(){
    
    TextStyle negrita = TextStyle(fontWeight:FontWeight.bold);

    return Card(
      margin: EdgeInsets.only(top: 10),
      elevation: 10.0,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0) ),
      child: Container(
        padding: EdgeInsets.all(15.0),
        child:Column(
          children: <Widget>[
            Text("¿Que tanto afecta el olor que percibes tu estado de ánimo?",style: TextStyle(color: Colors.black, fontSize: 17.0)),
            Slider(
              min: 0.0,
              max: 10.0,
              divisions: 10,
              value: sliderAfectacionValue,
              activeColor: Colors.orange,
              inactiveColor: Colors.grey,
              onChanged: (newValue){
                setState(() {
                  sliderAfectacionValue = newValue;
                });
              },
            ),
            Row(
              children: <Widget>[
            Text("Poco", style: negrita),
            Expanded(child: SizedBox()),
            Text("Mucho",  style: negrita )
              ],
            )
          ],
        )
      )

    );
  }

  Widget _olorResulta(){
    TextStyle negrita = TextStyle(fontWeight:FontWeight.bold);

    return Card(
      margin: EdgeInsets.only(top: 10),
      elevation: 10.0,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0) ),
      child: Container(
        padding: EdgeInsets.all(15.0),
        child:Column(
          children: <Widget>[
            Text("Ese olor que percibes, ¿te resulta?",style: TextStyle(color: Colors.black, fontSize: 17.0)),
            Slider(
              min: 0.0,
              max: 10.0,
              divisions: 10,
              value: sliderResultaValue,
              activeColor: Colors.orange,
              inactiveColor: Colors.grey,
              onChanged: (newValue){
                setState(() {
                  sliderResultaValue = newValue;
                });
              },
            ),
            Row(
              children: <Widget>[
            Text("Agradable", style: negrita),
            Expanded(child: SizedBox()),
            Text("Desagradable",  style: negrita )
              ],
            )
          ],
        )
      )

    );
  }

  Widget _olorEmocion(){
    return Card(
      margin: EdgeInsets.only(top: 10),
      elevation: 10.0,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0) ),
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("¿Qué emoción le genera el olor?", style: TextStyle(color: Colors.black, fontSize: 17.0)),
          DropdownButton<String>(
            items: _emociones.map((String dropDownStringItem){

              return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
              );

            }).toList()
            ,
            onChanged: (String newValueSelected){
              setState(() {
                this._currentEmocionSelected =newValueSelected;
              });
            },
            value: _currentEmocionSelected,
          )
          ],
      ),
      )
    );
  }

  Widget _olorReaccion(){
      return Card(
      margin: EdgeInsets.only(top: 10),
      elevation: 10.0,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0) ),
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("¿Qué reacción le produce?", style: TextStyle(color: Colors.black, fontSize: 17.0)),
            SizedBox(height: 10,)
            ,
          DropdownButton<String>(
            items: _reacciones.map((String dropDownStringItem){

              return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
              );

            }).toList()
            ,
            onChanged: (String newValueSelected){
              setState(() {
                this._currentReaccionSelected =newValueSelected;
              });
            },
            value: _currentReaccionSelected,
          )
          ],
      ),
      )
    );
    
  }

  Future _registrar(Map<String, Object> datos, context ) async {

    setState(() {
         isbuttondisabled = true;
        }); 
      
    var alertdialog = AlertDialog(
        title: Text("Datos del olor registrados."),
        content: Text("¿Desea continuar en la aplicación?"),
        actions: <Widget>[
          FlatButton(
            child: Text('Sí'),
            onPressed: () {
               Navigator.pushNamed(context, '/');
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



      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
         //print('connected');

        Map<String, dynamic> user = jsonDecode(this.savedUser);
        
        olor.coordenadas = datos['coordenadas'];
        DateTime now = new DateTime.now();
        olor.fecha=now.toString();
        olor.intensidad= datos['intensidad'];
        olor.nombreOlor = [datos['Nombre'], datos['num']];
        olor.nivelDistincion = datos['distincion'];
        olor.nivelAfectacion= sliderAfectacionValue;
        olor.nivelSatisfaccion = sliderResultaValue;
        olor.nivelEmocion=[_currentEmocionSelected,_emociones.indexOf(_currentEmocionSelected)];
        olor.reaccion = [_currentReaccionSelected, _reacciones.indexOf(_currentReaccionSelected)];
        olor.lugar = datos['lugar'];
        olor.sentimiento = datos['sentimiento'];
        olor.personalInformation = [user["Name"],user["Age"], user["Gender"], user["Profession"]];

        weatherProvider.getWeather(datos['coordenadas']).then((temp){
           olor.temperatura = temp;

           olorprovider.crearRegistroOlor(olor).then((sucess){

            setState(() {
            isbuttondisabled = false;
            }); 
          
            showDialog(
              context: context,
              builder: (BuildContext context){
                return alertdialog;
              }
            );
          }); 
        });

        

        }
    } on SocketException catch (_) {
      var alertdialog = AlertDialog(
        title: Text("No hay conexión"),
        content: Text("Para poder registrar necesita conexión a internet"),
        );

        showDialog(
          context: context,
          builder: (BuildContext context){
            return alertdialog;
          }
        );
    }




  }
}