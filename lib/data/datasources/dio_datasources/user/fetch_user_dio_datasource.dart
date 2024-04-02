import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ignition/data/dto/user_dto.dart';
import 'package:ignition/domain/entities/user_entity.dart';
import 'package:ignition/domain/usecases/user_usecases/user_exceptions.dart';
import 'package:ignition/utils/constants.dart';

class FetchUserDioDatasourceImpl {
  Future<Either<IUserUsecaseExceptions, List<UserEntity>>> call(
      String token) async {
    try {
      Dio dio = Dio();

      Response response = await dio.get(
        '${ProjectGlobalsVariables.apiUrl}/users',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        log(response.data.toString());
        var selectedUser = <UserEntity>[];
        for (var element in response.data) {
          selectedUser.add(UserDTO.fromMap(element));
        }
        return Right(selectedUser);
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
