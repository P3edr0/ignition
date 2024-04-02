import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/igde_datasources.dart';
import 'package:ignition/domain/usecases/igde_usecases/igde_exceptions.dart';
import 'package:ignition/utils/constants.dart';

class InsertIgdeDioDatasourceImpl implements IInsertIgdeDatasource {
  @override
  Future<Either<IIgdeUsecaseExceptions, String>> call(Map userData) async {
    Dio dio = Dio();

    try {
      Response response = await dio.post(
        '${ProjectGlobalsVariables.apiUrl}/igdes',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'name': userData['name'],
          'email': userData['email'],
          'password': userData['password'],
        },
      );

      if (response.statusCode == 201) {
        return Right(response.data['insertId'].toString());
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
