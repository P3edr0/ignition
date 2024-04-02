import 'package:dartz/dartz.dart';
import 'package:ignition/data/datasources/dio_datasources/user/fetch_user_dio_datasource.dart';
import 'package:ignition/domain/entities/user_entity.dart';
import 'package:ignition/domain/usecases/user_usecases/user_exceptions.dart';

class FetchUserUsecases {
  Future<Either<IUserUsecaseExceptions, List<UserEntity>>> call(
      String token) async {
    return FetchUserDioDatasourceImpl().call(token);
  }
}
