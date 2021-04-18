import 'package:fastmail_flutter/src/bloc/mybullet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class AccountPage extends StatefulWidget {
  @override
  __AccountPageState createState() => __AccountPageState();
}

class __AccountPageState extends State<AccountPage> {
  static var _keyValidationForm = GlobalKey<FormState>();
  TextEditingController _textEditValor = TextEditingController();
  TextEditingController _textEditPeso = TextEditingController();
  TextEditingController _textEditConEmail = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  String _namearticulo;
  bool _showdetailprice = false;
  bool _fleteinterior = false;
  String _destinovalue;
  String _subtotal = "";
  String _total = "";
  String _totalquetzales = "";
  String _fleteInterior = "";
  String _flete = "";
  String _impuestos = "";
  String _manejo = "";
  String _seguro = "";
  String _almacenaje = "";
  String _polizamayor = "";
  @override
  void initState() {
    isPasswordVisible = false;
    isConfirmPasswordVisible = false; //AQUI se carga la lista desplegable
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        // toolbarHeight: 150, // Set this height

        backgroundColor: Colors.blue[900],
        elevation: 0,
        //leading: Icon(Icons.menu),
        title: Text("Mi Cuenta"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: Column(
              children: <Widget>[
                // getWidgetImageLogo(),
                //getWidgetRegistrationCard(),
                //getWidgetPriceCard(),
              ],
            )),
      ),
    );
  }
}
