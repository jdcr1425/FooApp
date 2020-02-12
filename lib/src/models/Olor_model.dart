// To parse this JSON data, do
//
//     final olorModelo = olorModeloFromJson(jsonString);

import 'dart:convert';

OlorModelo olorModeloFromJson(String str) => OlorModelo.fromJson(json.decode(str));

String olorModeloToJson(OlorModelo data) => json.encode(data.toJson());

///////////////////////////////////
OlorModelo olorModeloFromJsonNO(String str) => OlorModelo.fromJsonNO(json.decode(str));

String olorModeloToJsonNO(OlorModelo data) => json.encode(data.toJsonNO());



class OlorModelo {
    List<dynamic> coordenadas;
    double temperatura;
    List<dynamic> nombreOlor;
    double intensidad;
    double nivelDistincion;
    double nivelAfectacion;
    double nivelSatisfaccion;
    List<dynamic> nivelEmocion;
    List<dynamic> reaccion;
    String fecha;
    String lugar;
    String sentimiento;
    List<dynamic> personalInformation;

    OlorModelo({
        this.coordenadas,
        this.nombreOlor,
        this.intensidad,
        this.nivelDistincion,
        this.nivelAfectacion,
        this.nivelSatisfaccion,
        this.nivelEmocion,
        this.reaccion,
        this.fecha,
        this.lugar,
        this.sentimiento,
        this.temperatura,
        this.personalInformation
    });

    OlorModelo.otro({
      this.coordenadas,
      this.fecha
    });

    factory OlorModelo.fromJson(Map<String, dynamic> json) => new OlorModelo(
        coordenadas: new List<dynamic>.from(json["Coordenadas"].map((x) => x)),
        nombreOlor: new List<dynamic>.from(json["Nombre_olor"].map((x) => x)),
        intensidad: json["Intensidad"].toDouble(),
        nivelDistincion: json["Nivel_distincion"].toDouble(),
        nivelAfectacion: json["Nivel_afectacion"].toDouble(),
        nivelSatisfaccion: json["nivel_satisfaccion"],
        nivelEmocion: new List<dynamic>.from(json["Nivel_emocion"].map((x) => x)),
        reaccion: new List<dynamic>.from(json["reaccion"].map((x) => x)),
        fecha: json["fecha"],
        lugar: json["lugar"],
        sentimiento: json["sentimiento"],
        temperatura: json["Nivel_distincion"].toDouble(),
        personalInformation: new List<dynamic>.from(json["personalInformation"].map((x) => x)),
    );

     factory OlorModelo.fromJsonNO(Map<String, dynamic> json) => new OlorModelo(
        coordenadas: new List<dynamic>.from(json["Coordenadas"].map((x) => x)),
        fecha: json["fecha"]
    );

    Map<String, dynamic> toJson() => {
        "Coordenadas": new List<dynamic>.from(coordenadas.map((x) => x)),
        "Nombre_olor": new List<dynamic>.from(nombreOlor.map((x) => x)),
        "Intensidad": intensidad,
        "Nivel_distincion": nivelDistincion,
        "Nivel_afectacion": nivelAfectacion,
        "nivel_satisfaccion": nivelSatisfaccion,
        "Nivel_emocion": new List<dynamic>.from(nivelEmocion.map((x) => x)),
        "reaccion": new List<dynamic>.from(reaccion.map((x) => x)),
        "fecha" : fecha,
        "lugar" : lugar,
        "sentimiento" : sentimiento,
        "temperatura" : temperatura,
        "personalInformation" : new List<dynamic>.from(personalInformation.map((x) => x)),

    };
    Map<String, dynamic> toJsonNO() => {
        "Coordenadas": new List<dynamic>.from(coordenadas.map((x) => x)),
        "fecha" : fecha
    };
}
