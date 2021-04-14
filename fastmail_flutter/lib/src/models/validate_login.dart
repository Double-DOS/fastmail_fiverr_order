import 'dart:convert';

List<Loginn> postFromJson(String str) =>
    List<Loginn>.from(json.decode(str).map((x) => Loginn.fromJson(x)));
String postToJson(List<Loginn> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Loginn {
  final int pais;
  final int codigo;
  final String contrasena;
  final String verifica;
  final String tipousuario;
  final String email;
  final String nombres;
  final String apellidos;
  final String messagephp;

  Loginn(
      {this.pais,
      this.codigo,
      this.contrasena,
      this.verifica,
      this.tipousuario,
      this.email,
      this.nombres,
      this.apellidos,
      this.messagephp});

  factory Loginn.fromJson(Map<String, dynamic> json) => Loginn(
        verifica: json['verifica'],
        tipousuario: json['tipousuario'],
        email: json['email'],
        nombres: json['nombres'],
        apellidos: json['apellidos'],
        messagephp: json['messagee'],
      );

  Map<String, dynamic> toJson() => {
        'identificador': "CHECKLOGIN",
        'pais': pais,
        'codigo': codigo,
        'contrasena': contrasena,
      };
}
