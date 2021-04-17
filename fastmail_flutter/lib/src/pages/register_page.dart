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
  var url = Api.baseUrl + Api.register;
  final response = await http.post(url, headers: <String, String>{
    "Accept": "application/json"
  }, body: {
    "codpais": "502",
    "nombres": nombres,
    "contrasena": apellidos,
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
      loginn(context, data1['codigofm'], contrasena);
    } else {}
  } else {}
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
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static var _keyValidationForm = GlobalKey<FormState>();
  TextEditingController _textEditConName = TextEditingController();
  TextEditingController _textEditApellido = TextEditingController();
  TextEditingController _textEditDepartamento = TextEditingController();
  TextEditingController _textEditDireccion = TextEditingController();
  TextEditingController _textEditCelular = TextEditingController();
  TextEditingController _textEditConEmail = TextEditingController();
  TextEditingController _textEditConfirmContrasena = TextEditingController();
  TextEditingController _textEditContrasena = TextEditingController();
  TextEditingController _textEditNombreFactura = TextEditingController();
  TextEditingController _textEditNit = TextEditingController();
  TextEditingController _textEditServicio = TextEditingController();

  // TextEditingController _textEditConPassword = TextEditingController();
  // TextEditingController _textEditConConfirmPassword = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void initState() {
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
    loadDeptos();
    super.initState();
  }

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
    /*final FocusNode _passwordEmail = FocusNode();
    final FocusNode _passwordFocus = FocusNode();
    final FocusNode _passwordConfirmFocus = FocusNode();*/

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
                _crearDepartamento(),
                _crearDireccion(),
                _crearCelular(),
                _crearEmail(),
                _crearContrasena(),
                _crearConfirmContrasena(),
                _crearNombreFactura(),
                _crearNit(),
                _crearServicios(),
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
    /*return Container(
      child: TextFormField(
        controller: _textEditDepartamento,
        // focusNode: _crearApellido,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: _validateEmpty,
        onFieldSubmitted: (String value) {
          //  FocusScope.of(context).requestFocus(_passwordFocus);
        },
        decoration: InputDecoration(
            labelText: 'Departamento',
            //prefixIcon: Icon(Icons.email),
            icon: Icon(Icons.map)),
      ),
    );*/ //text field: email
    //padding: EdgeInsets.only(left: 15, right: 15, top: 5),
    //color: Colors.white,
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
                  value: _myState,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 20,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  hint: Text('Seleccionar el departamento'),
                  onChanged: (String newValue) {
                    setState(() {
                      _myState = newValue;
                      loadDeptos();
                      print(_myState);
                    });
                  },
                  items: statesList?.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['departamento']),
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
  }

  List statesList;
  String _myState;

  Future<String> loadDeptos() async {
    var url = Api.baseUrl + Api.queryselects;
    final response = await http.post(url,
        headers: <String, String>{"Accept": "application/json"},
        body: {"identificador": "DEPARTAMENTOS"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('loadDeptos Response: ${response.body}');
      dynamic data1 = jsonDecode(response.body);
      setState(() {
        statesList = data1;
      });
    } else {}
  }

  Widget _crearDireccion() {
    return Container(
      child: TextFormField(
        controller: _textEditDireccion,
        // focusNode: _crearApellido,
        keyboardType: TextInputType.emailAddress,
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

  Widget _crearContrasena() {
    return Container(
      child: TextFormField(
        controller: _textEditContrasena,
        obscureText: true,
        keyboardType: TextInputType.text,
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
        textInputAction: TextInputAction.next,
        validator: _validateEmpty,
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
      child: TextFormField(
        controller: _textEditServicio,
        // focusNode: _crearApellido,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: _validateEmpty,
        onFieldSubmitted: (String value) {
          //  FocusScope.of(context).requestFocus(_passwordFocus);
        },
        decoration: InputDecoration(
            labelText: '¿Qué servicios te interesan?',
            //prefixIcon: Icon(Icons.email),
            icon: Icon(Icons.miscellaneous_services)),
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
          'Guardar',
          style: TextStyle(fontSize: 16.0),
        ),
        onPressed: () {
          if (_keyValidationForm.currentState.validate()) {
            _onTappedButtonRegister();
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

  String _validatePassword(String value) {
    return value.length < 6 ? 'Min 6 char required' : null;
  }

  String _validateConfirmPassword(String value) {
    return value.length < 5 ? 'Min 5 char required' : null;
  }

  void _onTappedButtonRegister() {}

  void _onTappedTextlogin() {
    Navigator.pushReplacementNamed(context, 'login');
  }
}
