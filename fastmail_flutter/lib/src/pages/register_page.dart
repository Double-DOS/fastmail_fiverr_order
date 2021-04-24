import 'package:flutter/material.dart';
import 'package:fastmail_flutter/src/config/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> _createAccountToAPI(
    BuildContext context,
    String nombres,
    String apellidos,
    String departamento,
    String direccion,
    String dpi,
    String celular,
    String email,
    String contrasena,
    String nombrefactura,
    String idtributario,
    String interes,
    String tipocliente) async {
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
    print(data2.toString());
    print(int.parse(data2[0]['cantt']));
    if (int.parse(data2[0]['cantt']) == 0) {
      validEmail = false;
    } else {
      validEmail = true;
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
    if (int.parse(data3[0]['cantt']) == 0) {
      validCelular = false;
    } else {
      validCelular = true;
    }
  }
  print(validEmail.toString() + "---" + validCelular.toString());
  if ((validEmail == true) || (validCelular == true)) {
    if (validEmail == true) {
      showMessage(context, "Advertencia",
          "¡Error, ya existe una cuenta registrada con el email Ingresado!");
    }
    if (validCelular == true) {
      showMessage(context, "Advertencia",
          "¡Error, ya existe una cuenta registrada con ese numero de celular!");
    }
  }
  if ((validEmail == false) && (validCelular == false)) {
    var url = Api.baseUrl + Api.register;
    final response = await http.post(url, headers: <String, String>{
      "Accept": "application/json"
    }, body: {
      "codpais": "502",
      "nombres": nombres,
      "apellidos": apellidos,
      "departamento": departamento,
      "direccion": direccion,
      "dpi": dpi,
      "celular": celular,
      "email": email,
      "contrasena": contrasena,
      "nombrefactura": nombrefactura,
      "idtributario": idtributario,
      "interes": interes,
      "tipocliente": tipocliente
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      dynamic data1 = jsonDecode(response.body);
      print(data1.toString());
      if (data1['valida'] == 'true') {
        //DESPLEGAR ERROR DE (ERROR AL CREAR LA CUENTA)
        showMessage(
            context,
            "Advertencia",
            "¡Su cuenta ha sido creada exitosamente! Su codigo Fastmail es: " +
                data1['codigofm']);
        loginn(context, data1['codigofm'], contrasena);
      } else {}
    } else {}
  }
}

Future<String> loginn(
    BuildContext context, String coduser, String passw) async {
  var url = Api.baseUrl + Api.login;
  final response = await http.post(url,
      headers: <String, String>{"Accept": "application/json"},
      body: {"codpais": "502", "codigo": coduser, "contrasena": passw});
  print(response.statusCode);
  if (response.statusCode == 200) {
    print('resultValidLogin Response: ${response.body}');
    dynamic data1 = jsonDecode(response.body);
    print(data1.toString());
    if (data1['verifica'] == 'false') {
    } else {
      var gName = data1['nombres'];
      var gEmail = data1['email'];
      if (data1['tipousuario'] == 'CLIENTE') {
        Navigator.pushReplacementNamed(context, "homegrid",
            arguments: {"name": gName, "email": gEmail});
      } else if (data1['tipousuario'] == 'ADMIN') {}
    }
  } else {}
  return null;
}

showMessage(BuildContext context, String _dtittle, String _dmsg) {
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(_dtittle),
    content: Text(_dmsg),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static var _keyValidationForm = GlobalKey<FormState>();
  TextEditingController _textEditConName = TextEditingController();
  TextEditingController _textEditApellido = TextEditingController();
  //TextEditingController _textEditDepartamento = TextEditingController();
  TextEditingController _textEditDireccion = TextEditingController();
  TextEditingController _textEditCelular = TextEditingController();
  TextEditingController _textEditConEmail = TextEditingController();
  TextEditingController _textEditConfirmContrasena = TextEditingController();
  TextEditingController _textEditContrasena = TextEditingController();
  TextEditingController _textEditNombreFactura = TextEditingController();
  TextEditingController _textEditNit = TextEditingController();

  // TextEditingController _textEditConPassword = TextEditingController();
  // TextEditingController _textEditConConfirmPassword = TextEditingController();
  //
  FocusNode myFocusNodeEmail;
  FocusNode myFocusNodeCelular;
  //
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  String _servicioInteres;
  //PARA EL LISTADO DEPARTAMENTOS
  String _departamentSelected;
  List statesList2;
  String _myState2;
  //PARA EL CHECKBOX
  bool _checked = false;

  @override
  void initState() {
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
    loadDeptos();
    super.initState();
  }

// Your Custom API check.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
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
          new Image.network(
            'https://ougentre.sirv.com/Images/fastmail.png',
            width: 125.0,
            height: 125.0,
          ),
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
                    'Crear Cuenta',
                    style: TextStyle(fontSize: 19.0, color: Colors.black),
                  ),
                ), // title: login
                _crearNombre(), //text field : user name
                _crearApellido(),
                Center(child: _crearDepartamento()),
                _crearDireccion(),
                _crearCelular(),
                _crearEmail(),
                _crearContrasena(),
                _crearConfirmContrasena(),
                _crearNombreFactura(),
                _crearNit(),
                _crearServicios(),
                Center(child: _crearClienteProamerica()),
                _botonGuardar(),
                _yatienescuenta(),
              ],
            ),
          ),
        ),
      ),
    );
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

  Widget _crearDepartamento() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _myState2,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 20,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  hint: Text('Seleccione el departamento'),
                  onChanged: (String newValue) {
                    setState(() {
                      _myState2 = newValue;
                      _departamentSelected = _myState2;
                      print(_myState2);
                    });
                  },
                  items: statesList2?.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['departamento']),
                          value: item['departamento'].toString(),
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
  }

  Future<String> loadDeptos() async {
    var url = Api.baseUrl + Api.queryselects;
    if (_myState2 == null) {
      final response = await http.post(url,
          headers: <String, String>{"Accept": "application/json"},
          body: {"identificador": "DEPARTAMENTOS"});
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('loadDeptos Response: ${response.body}');
        dynamic data1 = jsonDecode(response.body);
        setState(() {
          statesList2 = data1;
        });
      }
    }
    return null;
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

  Widget _crearContrasena() {
    return Container(
      child: TextFormField(
        controller: _textEditContrasena,
        obscureText: true,
        keyboardType: TextInputType.text,
        maxLength: 20,
        textInputAction: TextInputAction.next,
        validator: _validateEmpty,
        onFieldSubmitted: (String value) {
          //  FocusScope.of(context).requestFocus(_passwordEmail);
        },
        decoration: InputDecoration(
            labelText: 'Contraseña',
            //prefixIcon: Icon(Icons.email),
            icon: Icon(Icons.perm_identity)),
      ),
    );
  }

  Widget _crearConfirmContrasena() {
    return Container(
      child: TextFormField(
        controller: _textEditConfirmContrasena,
        obscureText: true,
        keyboardType: TextInputType.text,
        maxLength: 20,
        textInputAction: TextInputAction.next,
        validator: validatePassword,
        onFieldSubmitted: (String value) {
          //  FocusScope.of(context).requestFocus(_passwordEmail);
        },
        decoration: InputDecoration(
            labelText: 'Confirmar Contraseña',
            //prefixIcon: Icon(Icons.email),
            icon: Icon(Icons.perm_identity)),
      ),
    );
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

  Widget _crearServicios() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _servicioInteres,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 20,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  hint: Text('¿Qué servicios te interesan?'),
                  onChanged: (String newValue) {
                    setState(() {
                      _servicioInteres = newValue;
                      print(_servicioInteres);
                    });
                  },
                  items: <String>[
                    'P.O. Box',
                    'Mini Carga',
                    'P.O. Box / Mini Carga',
                    'Otros'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearClienteProamerica() {
    return Container(
      child: CheckboxListTile(
        title: Text("Soy Cliente Promerica"),
        value: _checked,
        onChanged: (bool value) {
          setState(() {
            _checked = value;
          });
        },
      ),
    );
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
          'Guardar',
          style: TextStyle(fontSize: 16.0),
        ),
        onPressed: () {
          String _tipoCliente;
          if (_checked == true) {
            _tipoCliente = 'Promerica';
          } else {
            _tipoCliente = 'Fastmail';
          }
          if (_keyValidationForm.currentState.validate()) {
            _createAccountToAPI(
                context,
                _textEditConName.text,
                _textEditApellido.text,
                _departamentSelected,
                _textEditDireccion.text,
                "0",
                _textEditCelular.text,
                _textEditConEmail.text,
                _textEditContrasena.text,
                _textEditNombreFactura.text,
                _textEditNit.text,
                _servicioInteres,
                _tipoCliente);
          }
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }

  Widget _yatienescuenta() {
    return Container(
        margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '¿Ya tienes cuenta? ',
            ),
            InkWell(
              splashColor: Colors.blueAccent.withOpacity(0.5),
              onTap: () {
                _onTappedTextlogin();
              },
              child: Text(
                ' Ingresar',
                style: TextStyle(
                    color: Colors.blueAccent, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ));
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

  /*Future<String> _verifyEmailOnFastmailBD(String email) async {
    var url = Api.baseUrl + Api.queryselects;
    final response = await http.post(url, headers: <String, String>{
      "Accept": "application/json"
    }, body: {
      "identificador": "VALIDEMAIL",
      "codpais": "502",
      "email": email,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('_verifyEmailOnFastmail Response: ${response.body}');
      dynamic data1 = jsonDecode(response.body);
      if (data1['cant'] == '500') {
      } else {}
    } else {}
    return null;
  }*/

  String _validatePassword(String value) {
    return value.length < 6 ? 'Min 6 char required' : null;
  }

  String _validateConfirmPassword(String value) {
    return value.length < 5 ? 'Min 5 char required' : null;
  }

  void _onTappedTextlogin() {
    Navigator.pushReplacementNamed(context, 'login');
  }

  String validatePassword(String value) {
    print("valorrr $value passsword ${_textEditContrasena.text}");
    if (value != _textEditContrasena.text) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }
}
