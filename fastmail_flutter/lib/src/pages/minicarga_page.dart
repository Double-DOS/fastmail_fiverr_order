import 'package:fastmail_flutter/src/bloc/mybullet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MiniCargaPage extends StatefulWidget {
  @override
  __MiniCargaPageState createState() => __MiniCargaPageState();
}

class __MiniCargaPageState extends State<MiniCargaPage> {
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
    isConfirmPasswordVisible = false;
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
        title: Text("Mini Carga"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: Column(
              children: <Widget>[
                getWidgetImageLogo('./assets/images/MiniCarga.png'),
                getWidgetRegistrationCard(),
              ],
            )),
      ),
    );
  }

  Widget getWidgetImageLogo(String img) {
    return Container(
      child: Column(
        children: <Widget>[
          new Image.asset(
            img,
            width: 125.0,
            height: 125.0,
          ),
          SizedBox(
            height: 3.0,
            width: double.infinity,
          ),
          Text(
            '¡Expandiendo tu NEGOCIO!',
            style: TextStyle(color: Colors.white, fontSize: 10.0),
          )
        ],
      ),
    );
  }

  Widget getWidgetRegistrationCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _keyValidationForm,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    'IMPORTA o EXPORTA  pequeñas cargas entre el Mundo y cualquier parte de Guatemala desde 25 libras en adelante. Este servicio es ideal para cargas que no llegan al mínimo de peso para Carga Regular o quue sobrepasa el promedio estándar de un paquete de P.O. Box.',
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 15.0),
                Center(child: _crearListado()),
                SizedBox(height: 15.0),
                getWidgetImageLogo('./assets/images/CargoEX.png'),
                _botonGuardar()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearListado() {
    return Center(
      child: Table(
          // border: TableBorder
          //     .all(), // Allows to add a border decoration around your table
          children: [
            TableRow(children: [Text('💲  Tarifas Especiales')]),
            TableRow(children: [Text('🛎️ Asesoria')]),
            TableRow(children: [Text('🔍 Seguimientoo a paquetes')]),
            TableRow(
                children: [Text('🚚 Entrega y recolecta en todo el país')]),
          ]),
    ); //text field: email
  }

  Widget _botonGuardar() {
    return Container(
      margin: EdgeInsets.only(top: 32.0),
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blueAccent,
        textColor: Colors.white,
        elevation: 5.0,
        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Text(
          'COTIZAR',
          style: TextStyle(fontSize: 16.0),
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'ctminicarga');
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }

  Widget _botonEnviarEmail() {
    return Container(
      margin: EdgeInsets.only(top: 32.0),
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blueAccent,
        textColor: Colors.white,
        elevation: 5.0,
        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Text(
          'Enviar',
          style: TextStyle(fontSize: 16.0),
        ),
        onPressed: () {
          // if (_keyValidationForm.currentState.validate()) {
          //_onTappedButtonCotizar();
          //  }
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }

  String _validateEmpty(String value) {
    return value != null ? "Campo obligatorio" : null;
  }

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Formato correo electrónico incorrecto';
    } else {
      return null;
    }
  }

  String _validatePassword(String value) {
    return value.length < 5 ? 'Min 5 char required' : null;
  }

  String _validateConfirmPassword(String value) {
    return value.length < 5 ? 'Min 5 char required' : null;
  }
}
