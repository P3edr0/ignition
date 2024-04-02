import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/delete_igde_dio_datasource.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/fetch_igde_dio_datasource.dart';
import 'package:ignition/domain/entities/igde_entity.dart';
import 'package:ignition/domain/usecases/igde_usecases/delete_igde_usecases.dart';
import 'package:ignition/domain/usecases/igde_usecases/fetch_igde_usecases.dart';
import 'package:ignition/domain/usecases/igde_usecases/update_igde_usecases.dart';
import 'package:ignition/domain/usecases/user_usecases/delete_user_usecases.dart';
import 'package:ignition/domain/usecases/user_usecases/fetch_user_usecases.dart';
import 'package:ignition/domain/usecases/user_usecases/insert_user_usecases.dart';
import 'package:ignition/domain/usecases/user_usecases/update_user_usecases.dart';
import 'package:ignition/presentation/ui/components/project_dialogs_widget.dart';
import 'package:ignition/presentation/ui/pages/home_page/home_page.dart';

class HomeController {
  final FetchUserUsecases _fetchUsersUsecases = FetchUserUsecases();
  final FetchIgdesUsecases _fetchIgdesUsecases = FetchIgdesUsecases();
  final DeleteIgdesUsecases _deleteIgdesUsecases = DeleteIgdesUsecases();
  final DeleteUserUsecases _deleteUserUsecases = DeleteUserUsecases();

  final UpdateIgdesUsecases _updateIgdesUsecases = UpdateIgdesUsecases();
  final InsertUserUsecases _insertUserUsecases = InsertUserUsecases();
  final UpdateUserUsecases _updateUserUsecases = UpdateUserUsecases();
  ListType currentListType = ListType.clients;

  List<IgdeEntity> userList = [];
  List<IgdeEntity> igdeList = [];
  List<IgdeEntity> currentList = [];
  Future deleteUsers(
      int id, int index, String token, BuildContext context) async {
    var result = await _deleteUserUsecases.call(
      {"id": id, "token": token},
    );

    result.fold((l) {
      ProjectDialogsWidget().alertDialog(
          context, 'Falha', 'Falha ao remover usuário', 'Voltar', () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }, (r) {
      ProjectDialogsWidget().alertDialog(
          context, 'Sucesso', 'Sucesso ao remover Usuário. ', 'Ok', () {
        currentList.removeAt(index);
        Navigator.pop(context);
        Navigator.pop(context);
      });
    });
  }

  Future deleteIgdes(
      int id, int index, String token, BuildContext context) async {
    var result = await _deleteIgdesUsecases.call(
      {"id": id, "token": token},
      DeleteIgdeDioDatasourceImpl(),
    );

    result.fold((l) {
      ProjectDialogsWidget().alertDialog(
          context, 'Sucesso', 'Sucesso ao remover Igde.', 'Ok', () {
        currentList.removeAt(index);
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }, (r) {
      ProjectDialogsWidget()
          .alertDialog(context, 'Falha', 'Falha ao remover Igde', 'Voltar', () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    });
  }

  Future<List<IgdeEntity>> fetchIgdes(String token) async {
    var result =
        await _fetchIgdesUsecases.call(token, FetchIgdeDioDatasourceImpl());
    return result.fold((l) {
      log(l.message);
      return [];
    }, (r) {
      log(r.toString(), name: "Retorno");
      return r;
    });
  }

  Future<List<IgdeEntity>> fetchUsers(String token) async {
    var result = await _fetchUsersUsecases.call(token);
    result.fold((l) => null, (r) {
      userList.clear();
      userList.addAll(r);
      log(r.toString());
    });
    return userList;
  }

  Future<void> updateIgde(
    int id,
    String nome,
    String email,
    String password,
    String confirmPassword,
    String token,
    BuildContext context,
  ) async {
    var result = await _updateIgdesUsecases.call(
      {
        'id': id,
        'name': nome,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'token': token,
      },
    );

    result.fold((l) {
      ProjectDialogsWidget().alertDialog(
          context, 'Falha', 'Falha ao atualizar Igde', 'Voltar', () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }, (r) {
      ProjectDialogsWidget().alertDialog(
          context, 'Sucesso', ' Recarregue a página e veja as alterações', 'Ok',
          () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    });
  }

  Future<Map> insertUser(
    String nome,
    String email,
    String tags,
    String token,
  ) async {
    var result = await _insertUserUsecases.call({
      'name': nome,
      'email': email,
      'tags': tags,
      'token': token,
    });
    return result.fold((l) => {"result": "fail", "message": l.message},
        (r) => {"result": "sucess", "message": "Usuário inserido com sucesso"});
  }

  Future<Map> updateUser(
    int id,
    String nome,
    String email,
    String tags,
    String token,
  ) async {
    var result = await _updateUserUsecases.call({
      'id': id,
      'name': nome,
      'email': email,
      'tags': tags,
      'token': token,
    });
    return result.fold(
        (l) => {"result": "fail", "message": l.message},
        (r) =>
            {"result": "sucess", "message": "Usuário atualizado com sucesso"});
  }
}
