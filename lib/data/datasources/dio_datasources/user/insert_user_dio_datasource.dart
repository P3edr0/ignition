import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ignition/domain/usecases/igde_usecases/igde_exceptions.dart';
import 'package:ignition/utils/constants.dart';

class InsertUserDioDatasourceImpl {
  Future<Either<IIgdeUsecaseExceptions, String>> call(Map userData) async {
    Dio dio = Dio();

    try {
      Response response = await dio.post(
        '${ProjectGlobalsVariables.apiUrl}/users',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${userData['token']}',
          },
        ),
        data: {
          'name': userData['name'],
          'email': userData['email'],
          'status': 'active',
          'tags': userData['tags'],
        },
      );

      if (response.statusCode == 201) {
        return Right(response.data.toString());
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
