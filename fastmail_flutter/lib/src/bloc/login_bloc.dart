import 'dart:async';
//import 'package:fastmail_flutter/src/bloc/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fastmail_flutter/src/bloc/validators.dart';

class LoginBloc with Validators {
  final _usuarioController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

// Recuperar los datos del Stream

  Stream<String> get usuarioStream => _usuarioController.stream;

  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(usuarioStream, passwordStream, (u, p) => true);

  //Insertar valores al Stream
  Function(String) get changeUsuario => _usuarioController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Obtener el 'ultimo valor del stream
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get usuario => _usuarioController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _usuarioController?.close();
  }
}
