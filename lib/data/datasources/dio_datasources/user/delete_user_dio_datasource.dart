import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ignition/domain/usecases/user_usecases/user_exceptions.dart';
import 'package:ignition/utils/constants.dart';

class DeleteUserDioDatasourceImpl {
  Future<Either<IUserUsecaseExceptions, String>> call(Map deleteData) async {
    Dio dio = Dio();

    try {
      Response response = await dio.delete(
        '${ProjectGlobalsVariables.apiUrl}/Users/${deleteData['id']}',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${deleteData['token']}',
          },
        ),
      );

      if (response.statusCode == 204) {
        return const Right('Sucesso');
      } else {
        log(response.data.toString(), name: response.statusCode.toString());
        return Left(NotFoundUserCaseException());
      }
    } catch (e, stack) {
      log(stack.toString(), name: e.toString());
      return Left(NotFoundUserCaseException());
    }
  }
}
