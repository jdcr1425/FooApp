import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:olores/src/models/Olor_model.dart';

class OloresProvider {
  final String _url = 'https://olores-4ad6a.firebaseio.com';

  Future<bool> crearRegistroOlor(OlorModelo olor) async {
    final url = '$_url/olores.json';
    final resp = await http.post(url, body: olorModeloToJson(olor));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }
}
