import 'package:flutter/material.dart';
import 'package:olores/src/pages/First_page.dart';

class LugarPage extends StatefulWidget {
  LugarPage({Key key}) : super(key: key);

  @override
  _LugarPageState createState() => _LugarPageState();
}

class _LugarPageState extends State<LugarPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<double> datos = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Descripción del Lugar",
          )),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xfff0f0f0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(5, 5))
              ]),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('¿Se encuentra usted en un lugar...?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 17)),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: Colors.orange,
                      textColor: Colors.white,
                      onPressed: () {
                        var obj = {'Coordenadas': datos, 'lugar': 'A'};
                        Navigator.pushNamed(context, FirstBlock.routeName,
                            arguments: obj);
                      },
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Text('Abierto', style: TextStyle(fontSize: 15.0)),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: Colors.orange,
                      textColor: Colors.white,
                      onPressed: () {
                        var obj = {'Coordenadas': datos, 'lugar': 'C'};
                        Navigator.pushNamed(context, FirstBlock.routeName,
                            arguments: obj);
                      },
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Text(
                        'Cerrado',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
