import 'package:dartz/dartz.dart';
import 'package:ignition/data/datasources/dio_datasources/user/update_user_dio_datasource.dart';
import 'package:ignition/domain/usecases/igde_usecases/igde_exceptions.dart';

class UpdateUserUsecases {
  Future<Either<IIgdeUsecaseExceptions, String>> call(Map userData) async {
    if (userData['name'] == '') {
      return Left(EmptyFieldCaseException());
    }
    if (userData['name'] == null) {
      return Left(NullUsecaseExceptions());
    }
    if (userData['email'] == '') {
      return Left(EmptyFieldCaseException());
    }
    if (userData['email'] == null) {
      return Left(NullUsecaseExceptions());
    }
    if (userData['tags'] == '') {
      return Left(EmptyFieldCaseException());
    }
    if (userData['tags'] == null) {
      return Left(NullUsecaseExceptions());
    }

    if (userData['id'] == '') {
      return Left(EmptyFieldCaseException());
    }
    if (userData['id'] == null) {
      return Left(NullUsecaseExceptions());
    }
    if (userData['token'] == '') {
      return Left(EmptyFieldCaseException());
    }
    if (userData['token'] == null) {
      return Left(NullUsecaseExceptions());
    }
    return UpdateUserDioDatasourceImpl().call(userData);
  }
}
