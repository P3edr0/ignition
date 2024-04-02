import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ignition/domain/usecases/igde_usecases/igde_exceptions.dart';
import 'package:ignition/utils/constants.dart';

class UpdateUserDioDatasourceImpl {
  Future<Either<IIgdeUsecaseExceptions, String>> call(Map userData) async {
    Dio dio = Dio();

    try {
      Response response = await dio.put(
        '${ProjectGlobalsVariables.apiUrl}/users/${userData['id']}',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${userData['token']}',
          },
        ),
        data: {
          'name': userData['name'],
          'email': userData['email'],
          'tags': userData['tags'],
          'status': 'active'
        },
      );

      if (response.statusCode == 204) {
        return const Right("Atualização feita com sucesso");
      } else {
        log(response.data.toString(), name: response.statusCode.toString());
        return Left(NotFoundIgdeCaseException());
      }
    } catch (e, stack) {
      log(stack.toString(), name: e.toString());
      return Left(NotFoundIgdeCaseException());
    }
  }
}
