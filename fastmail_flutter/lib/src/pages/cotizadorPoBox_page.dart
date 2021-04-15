import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class CotizadorPage extends StatefulWidget {
  @override
  __CotizadorPageState createState() => __CotizadorPageState();
}

class __CotizadorPageState extends State<CotizadorPage> {
  static var _keyValidationForm = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void initState() {
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
    loadarticulos(); //AQUI se carga la lista desplegable
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
        title: Text("Cotizador"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 32.0),
            child: Column(
              children: <Widget>[
                getWidgetImageLogo(),
                getWidgetRegistrationCard(),
              ],
            )),
      ),
    );
  }

  Widget getWidgetImageLogo() {
    return Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Column(
        children: <Widget>[
          // new Image.network(
          //   'https://ougentre.sirv.com/Images/fastmail.png',
          //   width: 125.0,
          //   height: 125.0,
          // ),
          SizedBox(
            height: 10.0,
            width: double.infinity,
          ),
          // Text(
          //   'FastMail',
          //   style: TextStyle(color: Colors.white, fontSize: 25.0),
          // )
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
                    'Cotizar',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ),
                _crearTipoArticulo(),
                _crearValor(),
                _crearPeso(),
                _crearDestino(),
                _botonGuardar()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearTipoArticulo() {
    //INICIO LISTA DESPLEGABLE
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _myState,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  hint: Text('Seleccionar tipo de artículo'),
                  onChanged: (String newValue) {
                    setState(() {
                      _myState = newValue;
                      loadarticulos();
                      print(_myState);
                    });
                  },
                  items: statesList?.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['name']),
                          value: item['id'].toString(),
                        );
                      })?.toList() ??
                      [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    //FIN LISTA DESPLEGABLE
  }

  List statesList;
  String _myState;

  Future<String> loadarticulos() async {
    var url = 'https://webyte.com.gt/projects/apps/fastmail/executequerys.php';
    final response = await http.post(url,
        headers: <String, String>{"Accept": "application/json"},
        body: {"identificador": "ARTICULOS"});
    //print(response.statusCode);
    if (response.statusCode == 200) {
      //print('resultValidLogin Response: ${response.body}');
      dynamic data1 = jsonDecode(response.body);
      //print(data1.toString());
      setState(() {
        statesList = data1;
      });
    } else {
      //showAlertDialog(context, "¡Ocurrió un error al obtener datos!");
      //throw Exception('Failed to get data');
    }
  }

  // return Container(
  //   child: TextFormField(
  //     //   controller: _textEditApellido,
  //     // focusNode: _crearApellido,
  //     keyboardType: TextInputType.text,
  //     textInputAction: TextInputAction.next,
  //     validator: _validateEmpty,
  //     onFieldSubmitted: (String value) {
  //       //  FocusScope.of(context).requestFocus(_passwordFocus);
  //     },
  //     decoration: InputDecoration(
  //         labelText: 'Tipo de Artículo',
  //         //prefixIcon: Icon(Icons.email),
  //         icon: Icon(Icons.card_giftcard_outlined)),
  //   ),
  // ); //text field: email
  //}

  Widget _crearValor() {
    return Container(
        child: TextFormField(
      //    controller: _textEditDepartamento,
      // focusNode: _crearApellido,
      keyboardType: TextInputType.numberWithOptions(),
      textInputAction: TextInputAction.next,
      validator: _validateEmpty,
      onFieldSubmitted: (String value) {
        //  FocusScope.of(context).requestFocus(_passwordFocus);
      },
      decoration: InputDecoration(
        labelText: 'Valor',
        //prefixIcon: Icon(Icons.monetization_on_sharp),
        icon: Icon(Icons.monetization_on_sharp),
      ),
    )); //text field: email
  }

  Widget _crearPeso() {
    return Container(
      child: TextFormField(
        //    controller: _textEditDepartamento,
        // focusNode: _crearApellido,
        keyboardType: TextInputType.numberWithOptions(),
        textInputAction: TextInputAction.next,
        validator: _validateEmpty,
        onFieldSubmitted: (String value) {
          //  FocusScope.of(context).requestFocus(_passwordFocus);
        },
        decoration: InputDecoration(
            labelText: 'Peso',
            //prefixIcon: Icon(Icons.email),
            icon: Icon(Icons.run_circle_outlined)),
      ),
    ); //text field: email
  }

  Widget _crearDestino() {
    return Container(
      child: TextFormField(
        //    controller: _textEditDireccion,
        // focusNode: _crearApellido,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        validator: _validateEmpty,
        onFieldSubmitted: (String value) {
          //  FocusScope.of(context).requestFocus(_passwordFocus);
        },
        decoration: InputDecoration(
            labelText: 'Destino',
            //prefixIcon: Icon(Icons.email),
            icon: Icon(Icons.gps_fixed)),
      ),
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
          // if (_keyValidationForm.currentState.validate()) {
          _onTappedButtonCotizar();
          //  }
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }

  String _validateEmpty(String value) {
    return value.trim().isEmpty ? "Campo obligatorio" : null;
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

  Future<String> _onTappedButtonCotizar() async {
    var url = 'https://webyte.com.gt/projects/apps/fastmail/executequerys.php';
    final response = await http.post(url, headers: <String, String>{
      "Accept": "application/json"
    }, body: {
      "identificador": "COTIZAR",
      "codpais": "502",
      "codarticulo": "1",
      "articulo": "-",
      "valor": "108",
      "peso": "1",
      "destino": "Ciudad Capital",
      "tipocliente": "Fastmail"
    });
    //print(response.statusCode);
    if (response.statusCode == 200) {
      //print('resultValidLogin Response: ${response.body}');
      dynamic data1 = jsonDecode(response.body);
      print(data1.toString());
      // setState(() {
      //   statesList = data1;
      // });
    } else {
      //showAlertDialog(context, "¡Ocurrió un error al obtener datos!");
      //throw Exception('Failed to get data');
    }
  }
}
