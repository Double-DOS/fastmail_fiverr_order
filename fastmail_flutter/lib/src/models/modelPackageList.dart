class MdlPackList {
  String tracking;
  String descpaquete;
  String estadoPack;
  String origenPack;
  String fechaUpdStatePack;

  MdlPackList(
      {this.tracking,
      this.descpaquete,
      this.estadoPack,
      this.origenPack,
      this.fechaUpdStatePack});

  factory MdlPackList.fromJson(Map<String, dynamic> json) {
    return MdlPackList(
      //codmcliente: json['idCliente'] as String,
      tracking: json['Tracking'] as String,
      descpaquete: json['Articulo'] as String,
      estadoPack: json['Descripstate'] as String,
      origenPack: json['origenn'] as String,
      fechaUpdStatePack: json['fechaup'] as String,
    );
  }
}
