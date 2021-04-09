// To parse this JSON data, do
//
//     final CargafacturaModel = cargafacturaModelFromJson(jsonString);

import 'dart:convert';

CargafacturaModel cargafacturaModelFromJson(String str) =>
    CargafacturaModel.fromJson(json.decode(str));

String CargafacturaModelToJson(CargafacturaModel data) =>
    json.encode(data.toJson());

class CargafacturaModel {
  String id;
  String titulo;
  double valor;
  bool disponible;
  String fotoUrl;

  CargafacturaModel({
    this.id,
    this.titulo = '',
    this.valor = 0.0,
    this.disponible = true,
    this.fotoUrl,
  });

  factory CargafacturaModel.fromJson(Map<String, dynamic> json) =>
      new CargafacturaModel(
        id: json["id"],
        titulo: json["titulo"],
        valor: json["valor"],
        disponible: json["disponible"],
        fotoUrl: json["fotoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "valor": valor,
        "disponible": disponible,
        "fotoUrl": fotoUrl,
      };
}
