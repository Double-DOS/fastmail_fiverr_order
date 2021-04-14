import 'package:fastmail_flutter/src/bloc/provider.dart';
import 'package:fastmail_flutter/src/pages/carga_factura.dart';
import 'package:fastmail_flutter/src/pages/cotizadorPoBox_page.dart';
import 'package:fastmail_flutter/src/pages/crearcuenta_page.dart';
import 'package:fastmail_flutter/src/pages/gridhome.dart';
import 'package:fastmail_flutter/src/pages/home_page.dart';
import 'package:fastmail_flutter/src/pages/homegrid_page.dart';
import 'package:fastmail_flutter/src/pages/login_page.dart';
import 'package:fastmail_flutter/src/pages/register_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FastMail Center',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          //'cargafactura': (BuildContext context) => CargaFacturaPage(),
          'crearcuenta': (BuildContext context) => CrearCuentaPage(),
          'homegrid': (BuildContext context) => GridHomePage(),
          'register': (BuildContext context) => RegisterScreen(),
          'cotizador': (BuildContext context) => CotizadorPage(),
        },
        theme: ThemeData(primaryColor: Colors.blue),
      ),
    );
  }
}
