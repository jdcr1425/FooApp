import 'package:flutter/material.dart';

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
    
    TextStyle textCardStyle = new TextStyle(fontSize: 20.0);
    TextStyle questionCardText = new TextStyle(color: Colors.black, fontSize: 22.0);

    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: Text("Descripción del Lugar", )
      ) ,
      body: Center(
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
                              child: Container(child: Text('¿Se encuentra usted en un lugar...?', style: questionCardText,textAlign:TextAlign.center,), )
                            ),SizedBox(height: 100.0,),
                            Row(mainAxisAlignment:MainAxisAlignment.center,
                              children: <Widget>[
                              RaisedButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                color: Colors.orange,
                                textColor: Colors.white,
                                onPressed: (){
                                  var obj = {'Coordenadas' : datos, 'lugar': 'A'};
                                  Navigator.pushNamed(context, '/first', arguments: obj);
                                },
                                padding: EdgeInsets.all(15),
                                child: Text('Abierto',style: textCardStyle),
                              ),
                              SizedBox(width: 60.0),
                              RaisedButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                color: Colors.orange,
                                textColor: Colors.white,
                                onPressed:(){
                                    var obj = {'Coordenadas' : datos, 'lugar': 'C'};
                                    Navigator.pushNamed(context, '/first', arguments: obj );
                                },
                                padding: EdgeInsets.all(15),
                                child: Text('Cerrado',  style: textCardStyle),
                              )
                            ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ),
                )
            ),
      
    );
    
    }

  

}