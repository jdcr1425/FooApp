import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherProvider {
  
  final String _url = 'https://api.darksky.net/forecast';
  final String apikey = '5faf7b997cfe492b021810ed8db48c88';

  Future<double> getWeather(List<double> coordenadas) async {
    final double latitude = coordenadas[0];
    final double longitude = coordenadas[1];

    final url = '$_url/$apikey/$latitude,$longitude';
    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    /* print("desde el provider" +
        decodedData["currently"]["temperature"].toStringAsFixed(2)); */

    return decodedData["currently"]["temperature"];
  }
}
