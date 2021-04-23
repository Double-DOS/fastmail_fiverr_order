//import 'package:fastmail_flutter/src/bloc/mybullet.dart';
import 'package:fastmail_flutter/src/config/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class CotizadorCourierPage extends StatefulWidget {
  @override
  __CotizadorCourierPageState createState() => __CotizadorCourierPageState();
}

class __CotizadorCourierPageState extends State<CotizadorCourierPage> {
  static var _keyValidationForm = GlobalKey<FormState>();
  TextEditingController _textEditValor = TextEditingController();
  TextEditingController _textEditPeso = TextEditingController();
  TextEditingController _textEditConEmail = TextEditingController();

  String _tipoDP = '';
  String _envioUrgNormal = '';
  String _destinoEnvio = '';

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  String _namearticulo;
  bool _showdetailprice = false;
  String _destinovalue;
  /*String _subtotal = "";
  String _total = "";
  String _totalquetzales = "";
  String _fleteInterior = "";
  String _flete = "";
  String _impuestos = "";
  String _manejo = "";
  String _seguro = "";
  String _almacenaje = "";
  String _polizamayor = "";*/
  @override
  void initState() {
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
    //loadarticulos(); //AQUI se carga la lista desplegable
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
        title: Text("Cotizador Courier"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: Column(
              children: <Widget>[
                // getWidgetImageLogo(),
                getWidgetRegistrationCard(),
                //getWidgetPriceCard(),
              ],
            )),
      ),
    );
  }

  /*Widget getDestino() {
    return DropdownButton<String>(
      isExpanded: true,
      value: _myState,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      style: TextStyle(
        color: Colors.black54,
        fontSize: 16,
      ),
      hint: Text('Seleccion el destino'),
      onChanged: (String newValue) {
        setState(() {
          _destinovalue = newValue;
        });
      },
      items:
          <String>['Ciudad Capital', 'Interior del país'].map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
    );
  }*/

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
                SizedBox(height: 16.0),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    'Cotiza el envío de documentos y/o paquetes a cualquier parte del mundo bajo la modalidad de urgente o normal.',
                    style: TextStyle(fontSize: 11.0, color: Colors.blue),
                  ),
                ),
                _crearTipo(),
                _crearEnvioNormalUrgente(),
                _crearDestinoEnvio(),
                //_crearValor(),
                _crearPeso(),
                //_crearDestino(),

                //getDestino(),
                _botonCalcular()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearTipo() {
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
                    value: _tipoDP,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    hint: Text('Seleccionar tipo'),
                    onChanged: (String newValue) {
                      setState(() {
                        _tipoDP = newValue;
                        //loadarticulos();
                        print(_tipoDP);
                      });
                    },
                    items: <String>['Documento', 'Paquete'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value.toString(),
                        child: new Text(value),
                      );
                    }).toList()),
              ),
            ),
          ),
        ],
      ),
    );
    //FIN LISTA DESPLEGABLE
  }

  Widget _crearEnvioNormalUrgente() {
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
                    value: _envioUrgNormal,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    hint: Text('Seleccionar tipo envío'),
                    onChanged: (String newValue) {
                      setState(() {
                        _envioUrgNormal = newValue;
                        print(_envioUrgNormal);
                      });
                    },
                    items: <String>['Normal', 'Urgente'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value.toString(),
                        child: new Text(value),
                      );
                    }).toList()),
              ),
            ),
          ),
        ],
      ),
    );
    //FIN LISTA DESPLEGABLE
  }

  Widget _crearDestinoEnvio() {
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
                    value: _destinoEnvio,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    hint: Text('Seleccionar Destino'),
                    onChanged: (String newValue) {
                      setState(() {
                        _destinoEnvio = newValue;
                        print(_destinoEnvio);
                      });
                    },
                    items: <String>[
                      'Miami',
                      'Resto de Estados Unidos',
                      'Centroamérica',
                      'Latinoameérica y Caribe',
                      'Europa',
                      'Asia'
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value.toString(),
                        child: new Text(value),
                      );
                    }).toList()),
              ),
            ),
          ),
        ],
      ),
    );
    //FIN LISTA DESPLEGABLE
  }

  /*Widget _crearEmail() {
    return Container(
      child: TextFormField(
        controller: _textEditConEmail,
        // focusNode: _crearApellido,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: _validateEmail,
        onFieldSubmitted: (String value) {
          //  FocusScope.of(context).requestFocus(_passwordFocus);
        },
        decoration: InputDecoration(
            labelText: 'Correo Electrónico',
            //prefixIcon: Icon(Icons.email),
            icon: Icon(Icons.email_outlined)),
      ),
    ); //text field: email
  }

  Widget _crearValor() {
    return Container(
        child: TextFormField(
      controller: _textEditValor,
      // focusNode: _crearApellido,
      keyboardType: TextInputType.numberWithOptions(),
      textInputAction: TextInputAction.next,
      validator: _validateEmpty,
      onFieldSubmitted: (String value) {
        //  FocusScope.of(context).requestFocus(_passwordFocus);
      },
      decoration: InputDecoration(
        labelText: 'Valor (\$)',
        //prefixIcon: Icon(Icons.monetization_on_sharp),
        icon: Icon(Icons.monetization_on_sharp),
      ),
    )); //text field: email
  }*/

  Widget _crearPeso() {
    return Container(
      child: TextFormField(
        controller: _textEditPeso,
        keyboardType: TextInputType.numberWithOptions(),
        textInputAction: TextInputAction.next,
        validator: _validateEmpty,
        onFieldSubmitted: (String value) {
          //  FocusScope.of(context).requestFocus(_passwordFocus);
        },
        decoration: InputDecoration(
            labelText: 'Peso (Libras)',
            icon: Icon(Icons.shopping_bag_outlined)),
      ),
    ); //text field: email
  }

  /*Widget _crearDestino() {
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
                    value: _destinovalue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    hint: Text('Seleccionar Destino'),
                    onChanged: (String newValue) {
                      setState(() => _destinovalue = newValue);
                      print(_destinovalue);
                    },
                    items: <String>['Ciudad Capital', 'Interior del país']
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value.toString(),
                        child: new Text(value),
                      );
                    }).toList()),
              ),
            ),
          ),
        ],
      ),
    );
  }*/

  Widget _botonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 32.0),
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blueAccent,
        textColor: Colors.white,
        elevation: 5.0,
        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Text(
          'CALCULAR',
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

  /*Widget _botonEnviarEmail() {
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
          _onTappedButtonCotizar();
          //  }
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }*/

  String _validateEmpty(String value) {
    return value != null ? "Campo obligatorio" : null;
  }

  /*String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Formato correo electrónico incorrecto';
    } else {
      return null;
    }
  }*/

  Future<String> _onTappedButtonCotizar() async {
    var url = Api.baseUrl + Api.queryselects;
    if (_textEditValor.text.toString() != null &&
        _textEditPeso.text.toString() != null &&
        _destinovalue.toString() != null) {
      final response = await http.post(url, headers: <String, String>{
        "Accept": "application/json"
      }, body: {
        "identificador": "COTIZAR",
        "codpais": "502",
        //"codarticulo": _myState.toString(),
        "articulo": _namearticulo.toString(),
        "valor": _textEditValor.text.toString(),
        "peso": _textEditPeso.text.toString(),
        "destino": _destinovalue,
        "tipocliente": "Fastmail"
      });
      //print(response.statusCode);
      if (response.statusCode == 200) {
        //print('resultValidLogin Response: ${response.body}');
        dynamic data1 = jsonDecode(response.body);
        print(data1.toString());
        print(data1['subtotal'].toString());
        /*_subtotal = data1['subtotal'].toString();
        _total = data1['total'].toString();
        _totalquetzales = data1['totalquetzales'].toString();
        _fleteInterior = data1['fleteInterior'].toString();
        _flete = data1['flete'].toString();
        _impuestos = data1['impuestos'].toString();
        _manejo = data1['manejo'].toString();
        _seguro = data1['seguro'].toString();
        _almacenaje = data1['almacenaje'].toString();
        _polizamayor = data1['polizamayor'].toString();*/
        //_showdetailprice = true;
        print(_showdetailprice);
        setState(() {
          if (!_showdetailprice) {
            _showdetailprice = true;
          } else {
            _showdetailprice = false;
          }

          /*if (_fleteInterior != "0.00") {
            _fleteinterior = true;
          } else {
            _fleteinterior = false;
          }*/
        });
      } else {
        //_showdetailprice = false;
      }
      return null;
    }
  }

  /*Widget getWidgetPriceCard() {
    return _showdetailprice == true
        ? Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Visibility(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 10.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text(
                          'Detalle de cotización',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Center(
                        child: Table(
                            // border: TableBorder
                            //     .all(), // Allows to add a border decoration around your table
                            children: [
                              TableRow(children: [
                                Text('Tipo de artículo:'),
                                Text(_namearticulo != null ? _namearticulo : "")
                              ]),
                              TableRow(children: [
                                Text('Valor:'),
                                Text("\$ " +
                                    (_textEditValor.text
                                            .toString()
                                            .trim()
                                            .isEmpty
                                        ? ""
                                        : _textEditValor.text.toString())),
                              ]),
                              TableRow(children: [
                                Text('Peso:'),
                                Text("   " +
                                    (_textEditPeso.text
                                            .toString()
                                            .trim()
                                            .isEmpty
                                        ? ""
                                        : _textEditPeso.text.toString()) +
                                    ' lbs.'),
                              ]),
                            ]),
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text(
                          'Detalle del pago',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Center(
                        child: Table(
                            // border: TableBorder
                            //     .all(), // Allows to add a border decoration around your table
                            children: [
                              TableRow(children: [
                                Text('Flete:'),
                                Text(_flete != null ? "\$ " + _flete : "")
                              ]),
                              TableRow(children: [
                                Text('Impuestos:'),
                                Text((_impuestos == null
                                    ? ""
                                    : "\$ " + _impuestos)),
                              ]),
                              TableRow(children: [
                                Text('Seguro:'),
                                Text("   " +
                                    (_seguro == null ? "" : "\$ " + _seguro)),
                              ]),
                              TableRow(children: [
                                Text('Manejo:'),
                                Text("   " +
                                    (_manejo == null ? "" : "\$ " + _manejo)),
                              ]),
                              _fleteinterior == true
                                  ? TableRow(children: [
                                      Text(
                                        'Envío al interior:',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text("   " +
                                          (_fleteInterior == null
                                              ? ""
                                              : "\$ " + _fleteInterior)),
                                    ])
                                  : TableRow(children: [
                                      Text(
                                        '',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text("   "),
                                    ]),
                              TableRow(children: [
                                Text(
                                  'Total:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("\$  " + (_total == null ? "" : _total)),
                              ]),
                            ]),
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text(
                          'Total + Importación: Q' +
                              (_totalquetzales == null ? "" : _totalquetzales),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text(
                          'Envíe esta cotización por correo electrónico',
                          style: TextStyle(color: Colors.black, fontSize: 14.0),
                        ),
                      ),
                      _crearEmail(),
                      _botonEnviarEmail(),
                      SizedBox(height: 45.0),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text(
                          'Puntos Importantes',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                      SizedBox(height: 45.0),
                      Column(
                        children: <Widget>[
                          new ListTile(
                            leading: new MyBullet(),
                            title: new Text(
                                'Esta cotización esta realizada con la tarifa de la opción Navegante.'),
                          ),
                          new ListTile(
                            leading: new MyBullet(),
                            title: new Text(
                                'Si esta compra aplica taxes de FL, estos saldrán hasta que se realice el pago con la tarjeta de credito, por favor tómelo en cuenta.'),
                          ),
                          new ListTile(
                            leading: new MyBullet(),
                            title: new Text(
                                'El valor mostrado es aproximado, en la realidad puede variar.'),
                          ),
                          new ListTile(
                            leading: new MyBullet(),
                            title: new Text(
                                'Si aplica se hará cobro por peso volumétrico.'),
                          ),
                          new ListTile(
                            leading: new MyBullet(),
                            title: new Text(
                                'Cobro mínimo en paquetes \$5.00 (Flete).'),
                          ),
                          new ListTile(
                            leading: new MyBullet(),
                            title: new Text(
                                'Esta cotización es válida por los siguientes 30 días a partir de la fecha actual.'),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: true,
            ),
          )
        : new Container();
  }*/
}
