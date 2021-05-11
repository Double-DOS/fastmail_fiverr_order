import 'package:flutter/material.dart';

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

  MdlPackList.fromJson(Map<String, dynamic> json) {
    tracking = json['Tracking'];
    descpaquete = json['Articulo'];
    estadoPack = json['Descripstate'];
    origenPack = json['origenn'];
    fechaUpdStatePack = json['fechaup'];
  }
}
