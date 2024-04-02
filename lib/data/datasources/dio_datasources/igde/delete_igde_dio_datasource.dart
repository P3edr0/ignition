import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/igde_datasources.dart';
import 'package:ignition/domain/usecases/igde_usecases/igde_exceptions.dart';
import 'package:ignition/utils/constants.dart';

class DeleteIgdeDioDatasourceImpl implements IDeleteIgdeDatasource {
  @override
  Future<Either<IIgdeUsecaseExceptions, String>> call(Map deleteData) async {
    Dio dio = Dio();

    try {
      Response response = await dio.delete(
        '${ProjectGlobalsVariables.apiUrl}/igdes/${deleteData['id']}',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${deleteData['token']}',
          },
        ),
      );

      if (response.statusCode == 204) {
        log(response.data.toString());
        return const Right("Sucess");
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
