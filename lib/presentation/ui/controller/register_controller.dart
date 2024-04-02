import 'package:flutter/material.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/insert_igde_dio_datasource.dart';
import 'package:ignition/domain/usecases/igde_usecases/insert_igde_usecases.dart';

class RegisterController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final InsertIgdesUsecases _insertIgdesUsecases = InsertIgdesUsecases();

  Future<Map> insertIgde(
    String nome,
    String email,
    String password,
    String confirmPassword,
  ) async {
    var result = await _insertIgdesUsecases.call({
      'name': nome,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    }, InsertIgdeDioDatasourceImpl());
    return result.fold(
        (l) => {"result": "fail", "message": "Falha ao inserir Igde"},
        (r) => {"result": "sucess", "message": "Igde inserido com sucesso"});
  }
}
