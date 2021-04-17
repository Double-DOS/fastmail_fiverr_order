import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FastMail Center'),
      ),
      body: Container(),
      floatingActionButton: _crearBotonConfig(context),
    );
  }

  _crearBotonConfig(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.settings),
      onPressed: () => Navigator.pushNamed(context, 'config'),
    );
  }
  // _crearBoton(BuildContext context) {
  //   return FloatingActionButton(
  //     child: Icon(Icons.add),
  //     onPressed: () => Navigator.pushNamed(context, 'cargafactura'),
  //   );
  // }
}
