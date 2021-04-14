import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fastmail_flutter/src/models/validate_login.dart';
import 'dart:async';

class Api {
  static const String baseUrl = 'https://webyte.com.gt/projects/apps/fastmail';

  static const login = '/login/login.php';
  static const register = '/login/register.php';

  Future<List<Loginn>> validuser() async {
    try {
      var url = baseUrl + login;
      final response = await http.post(url);
      if (response.statusCode == 200) {
        final List<Loginn> loginn_v = postFromJson(response.body);
        return loginn_v;
      }
    } catch (e) {
      return List<Loginn>();
    }
  }
}
