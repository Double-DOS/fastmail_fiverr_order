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
      tracking: json[0]['Tracking'] as String,
      descpaquete: json[0]['Articulo'] as String,
      estadoPack: json[0]['Descripstate'] as String,
      origenPack: json[0]['origenn'] as String,
      fechaUpdStatePack: json[0]['fechaup'] as String,
    );
  }
}
