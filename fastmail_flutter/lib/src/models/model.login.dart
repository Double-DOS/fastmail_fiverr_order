class ModelLogin {
  final int pais;
  final int codigo;
  final String contrasena;
  final String verifica;
  final String tipousuario;
  final String email;
  final String nombres;
  final String apellidos;
  final String messagephp;

  ModelLogin(
      {this.pais,
      this.codigo,
      this.contrasena,
      this.verifica,
      this.tipousuario,
      this.email,
      this.nombres,
      this.apellidos,
      this.messagephp});

  factory ModelLogin.fromJson(Map<String, dynamic> json) {
    return ModelLogin(
      verifica: json['verifica'],
      tipousuario: json['tipousuario'],
      email: json['email'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      messagephp: json['messagee'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pais': pais,
      'codigo': codigo,
      'contrasena': contrasena,
    };
  }
}
