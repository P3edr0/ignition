import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ignition/data/datasources/dio_datasources/igde/igde_datasources.dart';
import 'package:ignition/data/dto/igde_dto.dart';
import 'package:ignition/domain/entities/igde_entity.dart';
import 'package:ignition/domain/usecases/igde_usecases/igde_exceptions.dart';
import 'package:ignition/utils/constants.dart';

class FetchIgdeDioDatasourceImpl implements IFetchIgdeDatasource {
  @override
  Future<Either<IIgdeUsecaseExceptions, List<IgdeEntity>>> call(
      String token) async {
    Dio dio = Dio();

    try {
      Response response = await dio.get(
        '${ProjectGlobalsVariables.apiUrl}/igdes',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        var selectedIgde = <IgdeEntity>[];
        for (var element in response.data) {
          selectedIgde.add(IgdeDTO.fromMap(element));
        }
        return Right(selectedIgde);
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
