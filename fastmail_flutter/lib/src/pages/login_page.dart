import 'package:fastmail_flutter/src/bloc/provider.dart';
//import 'package:fastmail_flutter/src/services/services.login.dart';
import 'package:fastmail_flutter/src/models/model.login.dart';
import 'package:flutter/material.dart';
import 'package:fastmail_flutter/src/config/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

Future<String> loginn(
    BuildContext context, String coduser, String passw) async {
  var url = 'https://webyte.com.gt/projects/apps/fastmail/login/login.php';
  final response = await http.post(url,
      headers: <String, String>{"Accept": "application/json"},
      body: {"codpais": "502", "codigo": coduser, "contrasena": passw});
  print(response.statusCode);
  if (response.statusCode == 200) {
    print('resultValidLogin Response: ${response.body}');
    dynamic data1 = jsonDecode(response.body);
    print(data1.toString());
    if (data1['verifica'] == 'false') {
      /*showAlertDialog(
            context, "¡" + (data1['message']).replaceAll("#", "ñ") + "!");*/
    } else {
      var gName = data1['nombres'];
      var gEmail = data1['email'];
      if (data1['tipousuario'] == 'CLIENTE') {
        //Navigator.pushReplacementNamed(context, '/empleados');
        Navigator.pushReplacementNamed(context, "homegrid",
            arguments: {"name": gName, "email": gEmail});
        //Navigator.pushReplacementNamed(context, 'homegrid');
      } else if (data1['tipousuario'] == 'ADMIN') {
        //Navigator.pushReplacementNamed(context, '/page_mainclientes');
      }
    }
  } else {
    //showAlertDialog(context, "¡Ocurrió un error al obtener datos!");
    //throw Exception('Failed to get data');
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      _crearFondo(context),
      _loginForm(context),
    ]));
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: 175.0,
          )),
          Container(
            width: size.width * 0.90,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 30.0),
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
                Text(
                  'Inicio de sesión',
                  style: TextStyle(fontSize: 20.0),
                ),
                _crearUsuario(bloc),
                //SizedBox(height: 30.0),
                //_crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc, context),
                SizedBox(height: 30.0),
                _crearBotonCrearCuenta(context),
                SizedBox(height: 30.0),
                _crearBotonOlvidaPass(context),
              ],
            ),
          ),

          // _crearBotonOlvidaPass(),
        ],
      ),
    );
  }

  Widget _crearBoton(LoginBloc bloc, BuildContext context) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Ingresar'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            elevation: 0.0,
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: snapshot.hasData
                ? () => {
                      //ModelLogin modelLogin = ModelLogin(pais: "502",codigo: "53808",contrasena: "1234");
                      //  loadanimation(),
                      loginn(context, bloc.usuario, bloc.password)
                    } //Navigator.pushReplacementNamed(context, 'homegrid')
                : null);
      },
    );
  }

  // Widget _crearBotonOlvidaPass() {
  //   return RaisedButton(
  //       child: Container(
  //         padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 15.0),
  //         child: Text('Olvidaste tu contraseña?'),
  //       ),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
  //       elevation: 0.0,
  //       color: Colors.white,
  //       textColor: Colors.blue,
  //       onPressed: null);
  // }

  // Widget _crearBotonOlvidaPass() {
  //   return MaterialButton(
  //     minWidth: 245.0,
  //     height: 40.0,
  //     onPressed: () {},
  //     color: Colors.blue.shade200,
  //     child: Text('Olvidaste tu contraseña?',
  //         style: TextStyle(color: Colors.white)),
  //   );
  // }

  Widget _crearBotonOlvidaPass(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '',
            ),
            InkWell(
              splashColor: Colors.blueAccent.withOpacity(0.5),
              onTap: () {
                _onTappedTextforgotpass(context);
              },
              child: Text(
                ' ¿Olvidaste tu contraseña?',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ));
  }

  Widget _crearBotonCrearCuenta(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      minWidth: 245.0,
      height: 40.0,
      onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
      color: Colors.blue,
      child: Text('Crear Cuenta', style: TextStyle(color: Colors.white)),
    );
  }

  /*_login(LoginBloc bloc,BuildContext context) {
     print('Email: ${bloc.email} ');
     print('Password: ${bloc.password}');
   }*/

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock_outlined, color: Colors.blue),
                  hintText: 'Ingresa tu contraseña',
                  labelText: 'Contraseña',
                  //    counterText: snapshot.data,
                  errorText: snapshot.error),
              onChanged: bloc.changePassword,
            ));
      },
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: Colors.blue),
                hintText: 'Ingresa tu correo electrónico',
                labelText: 'Email',
                //counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearUsuario(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.usuarioStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                icon: Icon(Icons.person, color: Colors.blue),
                hintText: 'Ingresa tu cdigo',
                labelText: 'Codigo',
                // counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeUsuario,
          ),
        );
      },
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondocolor = Container(
      height: size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue[900],
        //  gradient: LinearGradient(colors: <Color>[
        //  Color.fromRGBO(34, 113, 179, 1.0),
        //  Color.fromRGBO(0, 170, 228, 1.0)
        //]
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondocolor,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 100.0),
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
        )
      ],
    );
  }

  void _onTappedTextforgotpass(BuildContext context) {
    Navigator.pushReplacementNamed(context, 'login');
  }
}
