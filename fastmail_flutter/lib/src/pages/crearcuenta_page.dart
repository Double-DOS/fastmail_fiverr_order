import 'package:email_validator/email_validator.dart';
import 'package:fastmail_flutter/src/bloc/provider.dart';
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
    //final bloc = Provider.of(context);
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
              _crearApellido(),
              _crearDepartamento(),
              _crearDireccion(),
              _crearCelular(),
              _crearEmail(),
              _crearPassword(),
              _crearConfirmPassword(),
              SizedBox(height: 30.0),
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

  Widget _crearDepartamento() {
    return TextFormField(
      initialValue: cargafactura.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Departamento'),
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

  Widget _crearDireccion() {
    return TextFormField(
      initialValue: cargafactura.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Dirección'),
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

  Widget _crearCelular() {
    return TextFormField(
      initialValue: cargafactura.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Celular'),
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

  Widget _crearEmail() {
    return TextFormField(
      initialValue: cargafactura.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Email'),
      onSaved: (value) => cargafactura.titulo = value,
      validator: (value) => EmailValidator.validate(value)
          ? null
          : "Formato de correo incorrecto.",
    );
  }

  Widget _crearPassword() {
    return TextFormField(
      initialValue: cargafactura.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Contraseña'),
      onSaved: (value) => cargafactura.titulo = value,
      validator: (value) {
        if (value.length < 6) {
          return 'Ingrese un valor correcto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearConfirmPassword() {
    return TextFormField(
      initialValue: cargafactura.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Confirmar contraseña'),
      onSaved: (value) => cargafactura.titulo = value,
      validator: (value) {
        if (value.length < 6) {
          return 'Ingrese un valor correcto';
        } else {
          return null;
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

  void _submit() {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    print(cargafactura.titulo);
    print(cargafactura.valor);
    print(cargafactura.disponible);
  }
}
