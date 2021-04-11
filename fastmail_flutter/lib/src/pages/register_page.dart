import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static var _keyValidationForm = GlobalKey<FormState>();
  TextEditingController _textEditConName = TextEditingController();
  TextEditingController _textEditConEmail = TextEditingController();
  TextEditingController _textEditConPassword = TextEditingController();
  TextEditingController _textEditConConfirmPassword = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void initState() {
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
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
    final FocusNode _passwordEmail = FocusNode();
    final FocusNode _passwordFocus = FocusNode();
    final FocusNode _passwordConfirmFocus = FocusNode();

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
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ), // title: login
                _crearNombre(), //text field : user name
                _crearApellido(),
                _crearDepartamento(),
                _crearDireccion(),
                _crearCelular(),
                _crearEmail(),
                _crearNombreFactura(),
                _crearNit(),
                _crearServicios(),

                // Container(
                //   child: TextFormField(
                //     controller: _textEditConEmail,
                //     focusNode: _passwordEmail,
                //     keyboardType: TextInputType.emailAddress,
                //     textInputAction: TextInputAction.next,
                //     validator: _validateEmail,
                //     onFieldSubmitted: (String value) {
                //       FocusScope.of(context).requestFocus(_passwordFocus);
                //     },
                //     decoration: InputDecoration(
                //         labelText: 'Email',
                //         //prefixIcon: Icon(Icons.email),
                //         icon: Icon(Icons.email)),
                //   ),
                // ), //text field: email
                // Container(
                //   child: TextFormField(
                //     controller: _textEditConPassword,
                //     focusNode: _passwordFocus,
                //     keyboardType: TextInputType.text,
                //     textInputAction: TextInputAction.next,
                //     validator: _validatePassword,
                //     onFieldSubmitted: (String value) {
                //       FocusScope.of(context)
                //           .requestFocus(_passwordConfirmFocus);
                //     },
                //     obscureText: !isPasswordVisible,
                //     decoration: InputDecoration(
                //         labelText: 'Password',
                //         suffixIcon: IconButton(
                //           icon: Icon(isPasswordVisible
                //               ? Icons.visibility
                //               : Icons.visibility_off),
                //           onPressed: () {
                //             setState(() {
                //               isPasswordVisible = !isPasswordVisible;
                //             });
                //           },
                //         ),
                //         icon: Icon(Icons.vpn_key)),
                //   ),
                // ), //text field: password
                // Container(
                //   child: TextFormField(
                //       controller: _textEditConConfirmPassword,
                //       focusNode: _passwordConfirmFocus,
                //       keyboardType: TextInputType.text,
                //       textInputAction: TextInputAction.done,
                //       validator: _validateConfirmPassword,
                //       obscureText: !isConfirmPasswordVisible,
                //       decoration: InputDecoration(
                //           labelText: 'Confirm Password',
                //           suffixIcon: IconButton(
                //             icon: Icon(isConfirmPasswordVisible
                //                 ? Icons.visibility
                //                 : Icons.visibility_off),
                //             onPressed: () {
                //               setState(() {
                //                 isConfirmPasswordVisible =
                //                     !isConfirmPasswordVisible;
                //               });
                //             },
                //           ),
                //           icon: Icon(Icons.vpn_key))),
                // ),
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
        validator: _validateUserName,
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
        controller: _textEditConEmail,
        // focusNode: _crearApellido,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: _validateEmail,
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
            labelText: 'Departamento',
            //prefixIcon: Icon(Icons.email),
            icon: Icon(Icons.map)),
      ),
    ); //text field: email
  }

  Widget _crearDireccion() {
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
            labelText: 'Dirección',
            //prefixIcon: Icon(Icons.email),
            icon: Icon(Icons.gps_fixed)),
      ),
    ); //text field: email
  }

  Widget _crearCelular() {
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

  Widget _crearNombreFactura() {
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
            labelText: 'Nombre de Factura',
            //prefixIcon: Icon(Icons.email),
            icon: Icon(Icons.receipt)),
      ),
    ); //text field: email
  }

  Widget _crearNit() {
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
            labelText: 'Nit',
            //prefixIcon: Icon(Icons.email),
            icon: Icon(Icons.perm_identity)),
      ),
    ); //text field: email
  }

  Widget _crearServicios() {
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

  String _validateUserName(String value) {
    return value.trim().isEmpty ? "Name can't be empty" : null;
  }

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Invalid Email';
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

  void _onTappedButtonRegister() {}

  void _onTappedTextlogin() {
    Navigator.pushReplacementNamed(context, 'login');
  }
}
