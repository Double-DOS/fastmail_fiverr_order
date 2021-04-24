class MdlPackList {
  final String tracking;
  final String descpaquete;
  final String estadoPack;
  final String origenPack;
  final String fechaUpdStatePack;

  MdlPackList(
      {this.tracking,
      this.descpaquete,
      this.estadoPack,
      this.origenPack,
      this.fechaUpdStatePack});

  factory MdlPackList.fromJson(Map<String, dynamic> jsonData) {
    return MdlPackList(
      //codmcliente: json['idCliente'] as String,
      tracking: jsonData['Tracking'],
      descpaquete: jsonData['Articulo'],
      estadoPack: jsonData['Descripstate'],
      origenPack: jsonData['origenn'],
      fechaUpdStatePack: jsonData['fechaup'],
    );
  }
}
