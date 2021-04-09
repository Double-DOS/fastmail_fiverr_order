import 'package:fastmail_flutter/src/models/cargafactura_model.dart';
import 'package:fastmail_flutter/src/utils/utils.dart' as utils;
import 'package:flutter/material.dart';

class CrearCuentaPage extends StatefulWidget {
  //const CargaFacturaPage({Key key}) : super(key: key);
  @override
  _CrearCuentaPageState createState() => _CrearCuentaPageState();
}

class _CrearCuentaPageState extends State<CrearCuentaPage> {
  final formKey = GlobalKey<FormState>();

  CargafacturaModel cargafactura = new CargafacturaModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear cuenta'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(children: <Widget>[
              _crearNombre(),
              //_crearPrecio(),
              // _crearDisponible(),
              _crearApellido(),
              _crearBoton(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: cargafactura.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre'),
      onSaved: (value) => cargafactura.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese un valor correcto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearApellido() {
    return TextFormField(
      initialValue: cargafactura.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Apellido'),
      onSaved: (value) => cargafactura.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese un valor correcto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: cargafactura.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio \$'),
      onSaved: (value) => cargafactura.valor = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo se permiten números';
        }
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.blue,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: _submit,
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: cargafactura.disponible,
      title: Text('Disponible'),
      onChanged: (value) => setState(() {
        cargafactura.disponible = value;
      }),
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    print(cargafactura.titulo);
    print(cargafactura.valor);
    print(cargafactura.disponible);
  }
}
