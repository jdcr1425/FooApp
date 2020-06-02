import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:olores/src/models/Olor_model.dart';

class OloresProvider {
  final String _url = 'https://olores-4ad6a.firebaseio.com';
  final String URL =
      "https://script.google.com/macros/s/AKfycbxAhc0J3V7DgiDmOIkWYHpWeQKI1DxDfAFpmV8YMnK31FhFpRw/exec";

  String _toParams(OlorModelo olor) {
    return "?olor=${olor.nombreOlor[0]}&lugar=${olor.lugar}&intesidad=${olor.intensidad}&nivel_distincion=${olor.nivelDistincion}&sentimiento=${olor.sentimiento}&nivel_afectacion=${olor.nivelAfectacion}&olor_resulta=${olor.nivelSatisfaccion}&emocion=${olor.nivelEmocion[0]}&reaccion=${olor.reaccion[0]}&fecha=${olor.fecha}&temperatura=${olor.temperatura}&coordenadas=${olor.coordenadas[0]} , ${olor.coordenadas[1]}&nombre=${olor.personalInformation[0]}&edad=${olor.personalInformation[1]}&profesion=${olor.personalInformation[3]}&sexo=${olor.personalInformation[2]}";
  }

  Future<bool> crearRegistroOlor(OlorModelo olor) async {
    //final url = '$_url/olores.json';
    final url = URL + _toParams(olor);

    print(url);
    //final resp = await http.post(url, body: olorModeloToJson(olor));

    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }
}
