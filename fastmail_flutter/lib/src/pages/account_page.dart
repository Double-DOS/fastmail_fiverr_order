import 'package:fastmail_flutter/src/bloc/provider.dart';
import 'package:fastmail_flutter/src/config/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:slimy_card/slimy_card.dart';

class AccountPage extends StatefulWidget {
  @override
  __AccountPageState createState() => __AccountPageState();
}

class __AccountPageState extends State<AccountPage> {
  static var _keyValidationForm = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  String _codigofastmail = '53808';
  TextEditingController _textEditConName = TextEditingController();
  TextEditingController _textEditApellido = TextEditingController();
  //TextEditingController _textEditDepartamento = TextEditingController();
  TextEditingController _textEditDireccion = TextEditingController();
  TextEditingController _textEditCelular = TextEditingController();
  TextEditingController _textEditConEmail = TextEditingController();
  TextEditingController _textEditNombreFactura = TextEditingController();
  TextEditingController _textEditNit = TextEditingController();

  @override
  void initState() {
    isPasswordVisible = false;
    isConfirmPasswordVisible = false; //AQUI se carga la lista desplegable
    _getInfoCliente();
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
      body: StreamBuilder(
        // This streamBuilder reads the real-time status of SlimyCard.
        initialData: false,
        stream: slimyCard.stream, //Stream of SlimyCard
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // SlimyCard is being called here.
              SlimyCard(
                color: Colors.white,
                topCardHeight: 400,
                bottomCardHeight: 750,
                width: 320,
                topCardWidget: topCardWidget((snapshot.data)
                    ? './assets/images/Cotizador.png'
                    : './assets/images/Cotizador.png'),
                bottomCardWidget: bottomCardWidget(),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget topCardWidget(String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Container(
        //   height: 80,
        //   width: 80,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(15),
        //     image: DecorationImage(image: AssetImage(imagePath)),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black.withOpacity(0.1),
        //         blurRadius: 20,
        //         spreadRadius: 1,
        //       ),
        //     ],
        //   ),
        // ),
        Text(
          'Código - FastMail',
          style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 15),
        Text(
          _codigofastmail == null ? "#" : _codigofastmail,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        Text(
          'Dirección en Miami',
          style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        Center(
          child: Table(
              // border: TableBorder
              //     .all(), // Allows to add a border decoration around your table
              children: [
                TableRow(children: [
                  Center(child: Text('2900 NW 112 Ave Unit F24')),
                ]),
                TableRow(children: [
                  Center(child: Text('#53 - ' + _codigofastmail)),
                ]),
                TableRow(children: [
                  Center(child: Text('Doral, FL 33172:')),
                ]),
                TableRow(children: [
                  Center(child: Text('Tel.: +1(786) 2270894')),
                ]),
              ]),
        ),
      ],
    );
  }

  // // This widget will be passed as Bottom Card's Widget.
  // Widget bottomCardWidget() {
  //   return Form(
  //     key: _keyValidationForm,
  //     child: Column(
  //       children: <Widget>[
  //         Container(
  //           alignment: Alignment.center,
  //           width: double.infinity,
  //           child: Text(
  //             'Crear Cuenta',
  //             style: TextStyle(fontSize: 19.0, color: Colors.black),
  //           ),
  //         ), // title: login
  //         // _crearNombre(), //text field : user name
  //         // _crearApellido(),
  //         // Center(child: _crearDepartamento()),
  //         // _crearDireccion(),
  //         // _crearCelular(),
  //         // _crearEmail(),
  //         // _crearContrasena(),
  //         // _crearConfirmContrasena(),
  //         // _crearNombreFactura(),
  //         // _crearNit(),
  //         // _crearServicios(),
  //         // Center(child: _crearClienteProamerica()),
  //         // _botonGuardar(),
  //         // _yatienescuenta(),
  //       ],
  //     ),
  //   );
  // }

  Widget bottomCardWidget() {
    /*final FocusNode _passwordEmail = FocusNode();
    final FocusNode _passwordFocus = FocusNode();
    final FocusNode _passwordConfirmFocus = FocusNode();*/
    return Form(
      key: _keyValidationForm,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Text(
              'Actualizar Perfil',
              style: TextStyle(
                fontSize: 19.0,
                color: Colors.black,
              ),
            ),
          ), // title: login
          _crearNombre(), //text field : user name
          _crearApellido(),
          _crearDireccion(),
          _crearCelular(),
          _crearEmail(),
          _crearNombreFactura(),
          _crearNit(),
          _botonGuardar(),
        ],
      ),
    );
  }

  Widget _account(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: 25,
          )),
          Container(
            width: size.width * 0.90,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 15.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0,
                  )
                ]),
            child: Column(
              children: <Widget>[
                _dirmiami(),
                // _botonUpdateData(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dirmiami() {
    final circulo = Container(
      width: 280.0,
      height: 80.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0), color: Colors.blue),
    );

    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Positioned(top: 50.0, left: 30.0, child: circulo),
              Text(
                'Mi dirección en Miami',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15.0),
              Center(
                child: Table(
                    // border: TableBorder
                    //     .all(), // Allows to add a border decoration around your table
                    children: [
                      TableRow(children: [
                        Center(child: Text('Tipo de artículo:')),
                      ]),
                      TableRow(children: [
                        Center(child: Text('Valor:')),
                      ]),
                      TableRow(children: [
                        Center(child: Text('Peso:')),
                      ]),
                    ]),
              ),
            ],
          ),
        )
      ],
    );
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

  String _validateEmpty(String value) {
    return value.trim().isEmpty ? "Campo obligatorio" : null;
  }

  Widget _crearNombre() {
    return Container(
      child: TextFormField(
        controller: _textEditConName,
        keyboardType: TextInputType.text,
        maxLength: 45,
        textInputAction: TextInputAction.next,
        validator: _validateEmpty,
        onFieldSubmitted: (String value) {
          //  FocusScope.of(context).requestFocus(_passwordEmail);
        },
        decoration: InputDecoration(
            labelText: 'Nombre',
            //prefixIcon: Icon(Icons.email),
            icon: Icon(Icons.perm_identity)),
      ),
    );
  }

  Widget _crearApellido() {
    return Container(
      child: TextFormField(
        controller: _textEditApellido,
        // focusNode: _crearApellido,
        maxLength: 45,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: _validateEmpty,
        onFieldSubmitted: (String value) {
          //  FocusScope.of(context).requestFocus(_passwordFocus);
        },
        decoration: InputDecoration(
            labelText: 'Apellido',
            //prefixIcon: Icon(Icons.email),
            icon: Icon(Icons.person_outline)),
      ),
    ); //text field: email
  }

  Widget _crearDireccion() {
    return Container(
      child: TextFormField(
        controller: _textEditDireccion,
        // focusNode: _crearApellido,
        keyboardType: TextInputType.emailAddress,
        maxLength: 99,
        textInputAction: TextInputAction.next,
        validator: _validateEmpty,
        onFieldSubmitted: (String value) {
          //  FocusScope.of(context).requestFocus(_passwordFocus);
        },
        decoration: InputDecoration(
            labelText: 'Dirección',
            //prefixIcon: Icon(Icons.email),
            icon: Icon(Icons.gps_fixed)),
      ),
    ); //text field: email
  }

  Widget _crearCelular() {
    return Container(
      child: TextFormField(
        controller: _textEditCelular,
        // focusNode: _crearApellido,
        keyboardType: TextInputType.emailAddress,
        maxLength: 25,
        textInputAction: TextInputAction.next,
        validator: _validateEmpty,
        onFieldSubmitted: (String value) {
          //  FocusScope.of(context).requestFocus(_passwordFocus);
        },
        decoration: InputDecoration(
            labelText: 'Teléfono Móvil',
            //prefixIcon: Icon(Icons.email),
            icon: Icon(Icons.phone_android_outlined)),
      ),
    ); //text field: email
  }

  Widget _crearEmail() {
    return Focus(
        child: TextFormField(
          controller: _textEditConEmail,
          // focusNode: _crearApellido,
          keyboardType: TextInputType.emailAddress,
          maxLength: 45,
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
        onFocusChange: (hasFocus) {});
    //text field: email
  }

  Widget _crearNombreFactura() {
    return Container(
      child: TextFormField(
        controller: _textEditNombreFactura,
        // focusNode: _crearApellido,
        keyboardType: TextInputType.emailAddress,
        maxLength: 35,
        textInputAction: TextInputAction.next,
        validator: _validateEmpty,
        onFieldSubmitted: (String value) {
          //  FocusScope.of(context).requestFocus(_passwordFocus);
        },
        decoration: InputDecoration(
            labelText: 'Nombre de Factura',
            //prefixIcon: Icon(Icons.email),
            icon: Icon(Icons.receipt)),
      ),
    ); //text field: email
  }

  Widget _crearNit() {
    return Container(
      child: TextFormField(
        controller: _textEditNit,
        // focusNode: _crearApellido,
        keyboardType: TextInputType.emailAddress,
        maxLength: 15,
        textInputAction: TextInputAction.next,
        //validator: _validateEmpty,
        onFieldSubmitted: (String value) {
          //  FocusScope.of(context).requestFocus(_passwordFocus);
        },
        decoration: InputDecoration(
            labelText: 'Nit',
            //prefixIcon: Icon(Icons.email),
            icon: Icon(Icons.perm_identity)),
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
          'Actualizar',
          style: TextStyle(fontSize: 16.0),
        ),
        onPressed: () {
          if (_keyValidationForm.currentState.validate()) {
            _updateAccountToAPI(
                context,
                _textEditConName.text,
                _textEditApellido.text,
                _textEditDireccion.text,
                _textEditCelular.text,
                _textEditConEmail.text,
                _textEditNombreFactura.text,
                _textEditNit.text);
          }
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }

  Future<String> _updateAccountToAPI(
      BuildContext context,
      String nombres,
      String apellidos,
      String direccion,
      String celular,
      String email,
      String nombrefactura,
      String idtributario) async {
    /**VALIDA QUE EL EMAIL NO EXISTA */
    bool validEmail = true;
    bool validCelular = true;
    var url2 = Api.baseUrl + Api.queryselects;
    final response2 = await http.post(url2, headers: <String, String>{
      "Accept": "application/json"
    }, body: {
      "identificador": "VALIDEMAIL",
      "codpais": "502",
      "email": email,
    });
    print(response2.statusCode);
    if (response2.statusCode == 200) {
      print('_verifyEmailOnFastmail Response: ${response2.body}');
      dynamic data2 = jsonDecode(response2.body);
      if (data2['Cant'] == '500') {
      } else {
        validEmail = false;
      }
    }

    var url3 = Api.baseUrl + Api.queryselects;
    final response3 = await http.post(url3, headers: <String, String>{
      "Accept": "application/json"
    }, body: {
      "identificador": "VALIDCELULAR",
      "codpais": "502",
      "celular": celular,
    });
    print(response3.statusCode);
    if (response3.statusCode == 200) {
      print('_verifyCelularOnFastmail Response: ${response3.body}');
      dynamic data3 = jsonDecode(response3.body);
      if (data3['Cant'] == '500') {
      } else {
        validCelular = false;
      }
    }

    if ((validEmail != false) && (validCelular != false)) {
      var url = Api.baseUrl + Api.updatequerys;
      final response = await http.post(url, headers: <String, String>{
        "Accept": "application/json"
      }, body: {
        "codpais": "502",
        "codigo": _codigofastmail,
        "nombres": nombres,
        "apellidos": apellidos,
        "direccion": direccion,
        "celular": celular,
        "email": email,
        "nombrefactura": nombrefactura,
        "idtributario": idtributario,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        dynamic data1 = jsonDecode(response.body);
        print(data1.toString());
        if (data1['valida'] == 'true') {
          //DESPLEGAR ERROR DE (ERROR AL CREAR LA CUENTA)
          //loginn(context, data1['codigofm'], contrasena);
        } else {}
      } else {}
    }
  }

  Future<String> _getInfoCliente() async {
    var url = Api.baseUrl + Api.queryselects;

    final response = await http.post(url, headers: <String, String>{
      "Accept": "application/json"
    }, body: {
      "codpais": "502",
      "identificador": "GETINFOPERSONAL",
      "codigo": _codigofastmail
    });
    if (response.statusCode == 200) {
      dynamic data1 = jsonDecode(response.body);
      print(data1.toString());

      _textEditConName.text = data1[0]['Nombres'].toString();
      _textEditApellido.text = data1[0]['Apellidos'].toString();
      _textEditDireccion.text = data1[0]['Direccion'].toString();
      _textEditCelular.text = data1[0]['celular'].toString();
      _textEditConEmail.text = data1[0]['email'].toString();
      _textEditNombreFactura.text = data1[0]['Nomfactura'].toString();
      _textEditNit.text = data1[0]['idtributario'].toString();
    } else {
      //_showdetailprice = false;
    }
  }
}
