import 'package:flutter/material.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/login_igde_dio_datasource.dart';
import 'package:ignition/domain/usecases/igde_usecases/login_igde_usecases.dart';

class LoginController {
  final LoginIgdesUsecases _loginIgdesUsecases = LoginIgdesUsecases();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<String> login(String email, String password) async {
    var result = await _loginIgdesUsecases.call(
        {'email': email, 'password': password}, LoginIgdeDioDatasourceImpl());
    return result.fold((l) => '', (r) => r['token']);
  }
}
